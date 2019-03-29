class LiveTestGroupsController < ApplicationController
  def index
    @test_groups = TestGroup.all
  end

  def show
    @test_group = TestGroup.find(params[:id])
    @solutions = {}
    @test_group.tests.each_with_index do |test, i|
      current_solutions = current_user.solutions.includes(:test).where(tests: { id: test.id})
      @solutions[i] = test.passed?(test.percents current_solutions.map(&:total_score).sum)
    end
  end
end
