class LiveSubjectsController < ApplicationController
  def index
    @subjects = Subject.all
  end

  def show
    @subject = Subject.find(params[:id])
    @solutions = {}
    @subject.test_groups.each_with_index do |test_group, i|
      current_solutions = current_user.solutions.includes(:test).where(tests: { test_group_id: test_group.id})
      @solutions[i] = test_group.passed?(test_group.percents current_solutions.map(&:total_score).sum)
    end
  end
end
