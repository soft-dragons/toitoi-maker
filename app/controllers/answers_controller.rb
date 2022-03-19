class AnswersController < ApplicationController
  before_action :authenticate_user!
  #before_action :set_ans


  def create
    answer = Answer.new(result: params[:result], user_id: params[:user_id], problem_id: params[:problem_id])
    answer.save!
  end

  private

  def answer_params
    params.require(:answer).permit(:result, :user_id, :problem_id)
  end
end
