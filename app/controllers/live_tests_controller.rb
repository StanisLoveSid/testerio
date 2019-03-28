class LiveTestsController < ApplicationController
  def index
    @tests = Test.all
  end

  def show
    @test = Test.find(params[:id])
    @questions = @test.questions.shuffle
    @a_z = ('a'..'z').to_a
    @next = TestGroup.find(@test.test_group_id).tests.where(["id > ?", @test.id]).first
    current_solution = current_user.solutions.where(["test_id = ?", @test.id]).first
    @user_max_score = current_solution.nil? ? 0 : current_solution.total_score
    @passed = @test.percents @user_max_score
  end

end
