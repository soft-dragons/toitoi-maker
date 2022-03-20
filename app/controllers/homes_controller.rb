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
        answer = problem.answers.where(user_id: current_user.id).order(id: "DESC").first
        if answer.present?
          if answer.updated_at <= Date.today && answer.result == "false"
             @num += 1
          end
        else
          if problem.updated_at <= Date.today || problem.answers.where(user_id: current_user.id).nil?
             @num += 1
          end
        end
      end


    end
  end

end
