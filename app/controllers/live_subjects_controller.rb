class LiveSubjectsController < ApplicationController
  def index
    @subjects = Subject.all
  end

  def show
    @subject = Subject.find(params[:id])
    @solutions = {}
    @subject.test_groups.each do |test_group|
      current_solutions = current_user.solutions.includes(:test).where(tests: { test_group_id: test_group.id})
      @solutions[test_group] = test_group.passed?(test_group.percents current_solutions.map(&:total_score).sum)
    end
  end
end
