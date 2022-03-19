class ProblemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_problem, only: [:show, :edit, :update, :destroy]
  before_action :user_rank, only: [:new, :show, :edit, :toitoi, :myProblems, :test]

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

  def update
    if @problem.update(problem_params)
      redirect_to problem_path(@problem), flash: { success: '問題を更新しました！'}
    else
      render :edit
    end
  end

  def toitoi #問問の問題（初級/中級/上級）
    @high_level, @medium_level, @low_level = Problem.new.divide_problems
    if params[:level] == "low"
       problem = @low_level.sample(1)
       @point = 1
    elsif params[:level] == "middle"
          problem = @medium_level.sample(1)
          @point = 3
    elsif params[:level] == "high"
          problem = @high_level.sample(1)
          @point = 5
    end
    if problem == []
       @problem = "false"
    else
       @problem = problem[0]
       answers = [[@problem.answer, 1], [@problem.incorrect1, 2], [@problem.incorrect2, 3]]
       @answers = answers.shuffle
    end
  end

  def show #問題の詳細画面
    @problem = Problem.find(params[:id])
    @feedback = Feedback.new
    @feedbacks = @problem.feedbacks.order(created_at: 'desc')
    @rate = Problem.new.calc_rate(@problem)
  end

  def edit #問題の編集画面
    if current_user.id != @problem.user_id
       redirect_to problem_path(@problem), flash: { danger: '投稿者が異なるため編集できません'}
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
    @problems = Problem.where(user_id: current_user.id, answer_id: answers.ids)
  end

  def test #復習の問題詳細
    # no_correct_answers = []
    # answer_list = current_user.answers
    # answer_list.each do |answer|
    #   if answer.nil?
    #     rate = Problem.new.calc_rate(Problem.find(answer.problem_id))
    #       if rete == 0
    #         no_correct_answers.push(answer)
    #       end
    #   end
    # end
    # check_date = 3
    Problem.where(user_id: current_user.id).each do |problem|
      #if problem.answers.where(result: false).any?
         answer = problem.answers.where(user_id: current_user.id).order(id: "DESC").first
         if answer.present?
            if answer.updated_at <= Date.today && answer.result == "false"
               @answer = answer
               break
            end
         else
            if problem.updated_at <= Date.today || problem.answers.where(user_id: current_user.id).nil?
               @answer = "first"
               @problem = problem
               break
            end
         end
      #end
    end
    # answerの条件
    # 最新のanswer かつ 最終更新日が3日前 かつ 同じproblem_idのanswerが全てfalseであるもの
    # に、紐づいているproblemがほじぃぃぃぃぃぃx
    if @answer == "first"
       answers = [[@problem.answer, 1], [@problem.incorrect1, 2], [@problem.incorrect2, 3]]
       @answers = answers.shuffle
    elsif @answer.present? && @answer != "first"
          @problem = @answer.problem
          answers = [[@problem.answer, 1], [@problem.incorrect1, 2], [@problem.incorrect2, 3]]
          @answers = answers.shuffle
    elsif @answer.nil?
          @problem = "false"
    end
  end

  private

  def set_problem
    @problem = Problem.find(params[:id])
  end

  def user_rank
    if user_signed_in?
       @users_array = User.pluck(:name, :point).sort_by(&:last).reverse
       num = 0
       @users_array.each do |user|
         if current_user.name == user[0]
            @rank = num + 1
         end
         num = num + 1
       end
   end
  end

  def problem_params
    params.require(:problem).permit(:title, :statement, :answer, :incorrect1, :incorrect2)
  end
end
