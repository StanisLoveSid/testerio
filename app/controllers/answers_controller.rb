class AnswersController < ApplicationController
  def create
    @answer = Answer.new(answers_params)
    if @answer.save
      flash[:success] = "answer is saved"
    else
      flash[:alert] = "something went wrong"
    end
    redirect_to @answer.question.test
  end

  private

  def answers_params
    params.require(:answer).permit(:exact_answer, :question_id, :score, :correct)
  end
end
