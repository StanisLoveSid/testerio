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
                             solutionable_id: params[:solution][:solutionable_id],
                             solutionable_type: params[:solution][:solutionable_type])
    @test = Test.find(params[:solution][:solutionable_id])
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
        max_score = @test.questions.map(&:answers).map{|answers| answers.map(&:score).sum}.sum
        progress = (score.to_f / max_score.to_f * 100.0).round(1)
      else
        flash[:alert] = "Something went wrong"
      end
    else
      flash[:alert] = "Have to answer all questions"
    end
    redirect_to live_test_path(@test, questions: correct_questions,
                               score: "Your score is #{@test.solutions.last.total_score}(#{progress}%)",
                               answers: selected_answers, percents: progress)
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
