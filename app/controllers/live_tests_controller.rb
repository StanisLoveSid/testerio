class LiveTestsController < ApplicationController
  def index
  	@tests = Test.all
  end

  def show
  	@test = Test.find(params[:id])
  	@questions = @test.questions.shuffle
  	@a_z = ('a'..'z').to_a
    @next = TestGroup.find(@test.test_group_id).tests.where(["id > ?", @test.id]).first
  end

end
