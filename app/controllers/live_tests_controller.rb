class LiveTestsController < ApplicationController
  def index
    @tests = Test.all
  end

  def show
    @test = Test.find(params[:id])
    @questions = @test.questions.shuffle
    @a_z = ('a'..'z').to_a
    @test_group = TestGroup.find(@test.test_group_id)
    @subject = Subject.find(@test_group.subject_id)
    @previous_test_group = @subject.test_groups.where(["id < ?", @test_group.id]).last
    @previous_test_group_score = @previous_test_group.score
    @user_previous_test_group_solutions = current_user.solutions.includes(:test).where(tests: { test_group_id: @previous_test_group.id})
    @previous_test_group_passed = @previous_test_group.passed?(@previous_test_group.percents @user_previous_test_group_solutions.map(&:total_score).sum)
    @previous = @test_group.tests.where(["id < ?", @test.id]).last
    @next = @test_group.tests.where(["id > ?", @test.id]).first
    unless @previous_test_group_passed
      redirect_back(fallback_location: live_test_group_path(@previous_test_group))
      flash[:alert] = "To access next group of tests, firstly you have to pass previous"
    end
    unless @previous.nil?
      previous_soulution = Solution.find_by(user_id: current_user.id, test_id: @previous.id)
      total_score = previous_soulution.nil? ? 0 : previous_soulution.total_score
      previous_passed = @previous.passed? (@previous.percents total_score)
      unless previous_passed
        redirect_back(fallback_location: live_test_path(@previous))
        flash[:alert] = "To access next test, firstly you have to pass previous"
      end
    end
    current_solution = current_user.solutions.where(["test_id = ?", @test.id]).first
    @user_max_score = current_solution.nil? ? 0 : current_solution.total_score
    @passed = @test.passed? (@test.percents @user_max_score)
  end

end
