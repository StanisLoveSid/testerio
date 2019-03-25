module LiveTestsHelper
  def correct_answers(question)
    unless params[:questions].nil?
      params[:questions][question.id.to_s] == "true" ? "Correct answer(s)" : "Wrong answer(s)"
    end
  end

  def checked_answers(answer)
    unless params[:answers].nil?
      params[:answers].include?(answer.id.to_s)
    end
  end

  def percents
    unless params[:percents].nil?
      (params[:percents].to_i >= 60)
    end
  end
end
