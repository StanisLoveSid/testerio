class SubjectsController < ApplicationController
  def create
    @subject = Subject.new(subject_params)
    if @subject.save
      flash[:success] = "subject is saved"
    else
      flash[:alert] = "something went wrong"
    end
    redirect_to @subject
  end

  def show
    @subject = Subject.find(params[:id])
  end

  private

  def subject_params
    params.require(:subject).permit(:title, :description, :user_id)
  end
end
