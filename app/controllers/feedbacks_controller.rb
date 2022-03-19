class FeedbacksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_feedback, only: [:update, :destroy]

  def create
    feedback = Feedback.find(params[:id])
    if feedback.save
      redirect_to problem_path(feedback.problem_id)
    else
      render 'problems/show'
    end
  end

  def update
    if @feedback.update(feedback_params)
      redirect_to problem_path(@feedback.problem_id)
    else
      render 'problems/show'
    end
  end

  def destroy
    @feedback.destroy
    redirect_to problem_path(@feedback.problem_id)
  end


  private

  def set_feedback
    @feedback = Feedback.find(params[:id])
  end

  def feedback_params
    params.require(:feedback).permit(:text)
  end
end