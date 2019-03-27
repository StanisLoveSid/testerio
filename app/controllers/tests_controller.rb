class TestsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  def index
    @tests = Test.all
  end

  def show
    @test = Test.find(params[:id])
    @questions = @test.questions
  end

  def create
    @test = Test.new(tests_params)
    if @test.save
      flash[:success] = "test is saved"
    else
      flash[:alert] = "something went wrong"
    end
    redirect_to root_path
  end

  def perform_test
    @test = Test.find(params[:id])
    @test.to_production
    if @test.save
      flash[:success] = "Test is ready for solving"
    else
      flash[:alert] = "something went wrong"
    end
    redirect_to live_test_path(@test)
  end

  private

  def tests_params
    params.require(:test).permit(:title, :description)
  end
end
