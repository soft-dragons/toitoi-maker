class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_ans


  def create
    problem = Problem.find(params[:id])
    answer = Answer.new(answer_params)
    answer.save
  end

  private

  def answer_params
    params.require(:answer).permit(:result)
  end
end
