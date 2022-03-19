class ProblemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_problem, only: [:show, :edit, :update, :destroy]

  def new #問題の新規登録
    @problem = Problem.new
  end

  def create
    @problem = current_user.problems.new(problem_params)
    if @problem.save
      redirect_to problem_path(@problem), flash: { success: '問題を作成しました！'}
    else
      flash.now[:danger] = '問題を作成できませんでした'
      render :new
    end
  end

  def toitoi #問問の問題一覧（初級/中級/上級）
  end

  def show #問題の詳細画面
  end

  def edit #問題の編集画面
    if current_user.id != @problem.user_id
      redirect_to problem_path(@problem), flash: { danger: '投稿者が異なるため編集できません。'}
    else
      @problem = Problem.where(problem_id : @problem.id)
    end
  end

  def update
    if @problem.update(problem_params)
      redirect_to show_path(@problem), flash: { success: '問題を更新しました！'}
    else
      render :edit
    end
  end

  def destroy
    @problem.destroy
    redirect_to myProblems_path, flash: { success; '問題を削除しました。'}
  end

  def myProblems #自分の問題一覧
  end

  def test_index #復習の問題一覧
  end

  def test #復習の問題詳細
  end

  private

  def set_problem
    @problem = Problem.find(params[:id])
  end

  def problem_params
    params.require(:problem).permit(:title, :statement, :answer, :incorrect1, :incorrect2)
  end
end
