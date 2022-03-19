class FeedbacksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_feedback, only: [:update, :destroy]

  def create
    @feedback = Feedback.new(feedback_params)
    if @feedback.save
      redirect_to problem_path(@feedback.problem_id)
    else
      @feedback = Feedback.new
      @problem = Problem.find(@feedback.problem_id)
      @feedbacks = @problem.feedbacks.order(created_at: 'desc')
      @rate = Problem.new.calc_rate(@problem)
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
    params.require(:feedback).permit(:text, :user_id, :problem_id)
  end
end