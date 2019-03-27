class LiveTestsController < ApplicationController
  def index
    @tests = Test.all
  end

  def show
    @test = Test.find(params[:id])
    @questions = @test.questions.shuffle
    @a_z = ('a'..'z').to_a
    @next = TestGroup.find(@test.test_group_id).tests.where(["id > ?", @test.id]).first
    @user_max_score = current_user.solutions.where(["test_id = ?", @test.id]).first.total_score
    @max_score = @test.score
    @progress = (@user_max_score.to_f / @max_score.to_f * 100.0).round(1)
  end

end
