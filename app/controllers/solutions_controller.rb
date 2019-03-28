class SolutionsController < ApplicationController

  def create
    score = 0
    params.permit!
    answers = params.to_h.collect do |key, value|
      [key, value] if ((key.to_i.is_a? Integer) && key.to_i != 0)
    end
    selected_answers = answers.compact.map{ |answer, question| answer }
    questions = answers_details answers, 0
    correctness = answers_details answers, 1
    scores = answers_details answers, 2
    correctness.each_with_index do |c, i|
      if c.include? false
        score += 0
      else
        score += scores[i].sum
      end
    end
    @solution = Solution.new(total_score: score,
                             user_id: params[:solution][:user_id],
                             test_id: params[:solution][:test_id])
    @test = Test.find(params[:solution][:test_id])
    answered_questions_amount = scores.count
    test_questions_amount = @test.questions.count
    correct_questions = {}
    state_of_answers = correctness.map{ |answers| answers.reduce(:&) }
    state_of_questions = questions.map { |questions| questions.uniq.first.to_i }
    if answered_questions_amount == test_questions_amount
      if @solution.save
        flash[:success] = "solution is saved"
        state_of_questions.each_with_index do |question, i|
          correct_questions[question] = state_of_answers[i]
        end
        redirect_to live_test_path(@test, questions: correct_questions,
                                   score: "Your score is #{@test.solutions.last.total_score}(#{@test.percents(score)}%)",
                                   answers: selected_answers)
        current_solutions = current_user.solutions.where("test_id = ?", @test.id)
        max_total_score = current_solutions.map(&:total_score).max
        latest_solution = current_solutions.map(&:created_at).max
        with_max_score = current_solutions.each {|solution| solution.destroy if solution.total_score < max_total_score}
        with_max_score.each {|solution| solution.destroy if solution.created_at < latest_solution && current_solutions.count > 1}
      else
        flash[:alert] = "Something went wrong"
        redirect_to live_test_path(@test, questions: correct_questions, answers: selected_answers)
      end
    else
      flash[:alert] = "Have to answer all questions"
      redirect_to live_test_path(@test, questions: correct_questions, answers: selected_answers)
    end
  end

  def answers_details(answers, i)
    answers.compact.group_by do |answer, question|
      question
    end.map do |question, answers|
      answers.map do |answer, question|
        [question, Answer.find(answer).correct, Answer.find(answer).score]
      end
    end.map {|e| e.map {|a| a[i]}}
  end
end
