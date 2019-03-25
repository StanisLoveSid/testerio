class QuestionsController < ApplicationController
  def create
    @question = Question.new(questions_params)
    if @question.save
      flash[:success] = "question is saved"
    else
      flash[:alert] = "something went wrong"
    end
    redirect_to @question.test
  end

  private

  def questions_params
    params.require(:question).permit(:exact_question, :test_id)
  end
end
