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
    end
  end

end
