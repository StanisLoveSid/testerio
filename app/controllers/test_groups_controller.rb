class TestGroupsController < ApplicationController
  def create
    @test_group = TestGroup.new(test_group_params)
    if @test_group.save
      flash[:success] = "test group is saved"
    else
      flash[:alert] = "something went wrong"
    end
    redirect_to @test_group.subject
  end

  private

  def test_group_params
    params.require(:test_group).permit(:title, :description, :subject_id, :user_id)
  end
end
