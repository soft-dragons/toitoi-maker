class HomesController < ApplicationController

  def top
    if user_signed_in?
       @users_array = User.pluck(:name, :point).sort_by(&:last).reverse
       num = 0
       @users_array.each do |user|
         if current_user.name == user[0]
            @rank = num + 1
         end
         num = num + 1
       end

       @num = 0
       Problem.where(user_id: current_user.id).each do |problem|
          #if problem.answers.where(result: false).any?
          answer = problem.answers.where(user_id: current_user.id).order(id: "DESC").first
          if answer.present?
            if answer.updated_at <= DateTime.now && answer.result == "false"
              @num = @num + 1
            end
          else
            if problem.updated_at <= DateTime.now || problem.answers.where(user_id: current_user.id).nil?
               @num = @num + 1
            end
          end
       end
    end
  end

end
