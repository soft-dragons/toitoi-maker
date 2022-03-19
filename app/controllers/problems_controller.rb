class ProblemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_problem, only: [:show, :edit, :update, :destroy]

  def new #問題の新規登録
    @problem = Problem.new
  end

  def create
    @problem = current_user.problems.new(problem_params)
    if @problem.answer_check && @problem.save
      redirect_to problem_path(@problem), flash: { success: '問題を作成しました！'}
    else
      flash.now[:danger] = '問題を作成できませんでした'
      render :new
    end
  end

  def toitoi #問問の問題（初級/中級/上級）
    @high_level, @medium_level, @low_level = Problem.new.divide_problems
    @high_index = @high_level.sample(10)
    @medium_index = @medium_level.sample(10)
    @low_index = @low_level.sample(10)
  end

  def show #問題の詳細画面
    @feedbacks = @problem.feedbacks.order(created_at: 'desc')
    @rate = calc_rate(@problem)
  end

  def edit #問題の編集画面
    if current_user.id != @problem.user_id
      redirect_to problem_path(@problem), flash: { danger: '投稿者が異なるため編集できません'}
    end
  end

  def update
    if @problem.update(problem_params)
      redirect_to problem_path(@problem), flash: { success: '問題を更新しました！'}
    else
      render :edit
    end
  end

  def myProblems #自分の問題一覧
    @problems = current_user.problems.order(created_at: 'desc')
  end

  def destroy
    @problem.destroy
    redirect_to myProblems_path, flash: { success: '問題を削除しました'}
  end

  def test_index #復習の問題一覧
    answers = current_user.answers.where(result: false)
    @problems = Problem.where(answer_id: answers.ids)
  end

  def test #復習の問題詳細
    # 自分が今まで一度も解けていないかつ今日が復習日になっている問題を１問ずつ取ってくる（.first）
    answers = current_user.answers
    no_correct_answers = []
    answers.each do |answer|
      rate = calc_rate(answer.problem_id)
      if rete == 0
        no_correct_answers.push(answer)
      end
    end

    check_date = 3
    problems = Problems.find_by(id: answers.product_ids, updated_at: Date.today - check_date)
  end

  private

  def set_problem
    @problem = Problem.find(params[:id])
  end

  def problem_params
    params.require(:problem).permit(:title, :statement, :answer, :incorrect1, :incorrect2)
  end
end
