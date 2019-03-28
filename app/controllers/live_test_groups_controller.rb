class LiveTestGroupsController < ApplicationController
  def index
    @test_groups = TestGroup.all
  end

  def show
    @test_group = TestGroup.find(params[:id])
  end
end
