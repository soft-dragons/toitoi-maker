# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  def edit
    @user = current_user
    @users_array = User.pluck(:name, :point).sort_by(&:last).reverse
    num = 0
    @users_array.each do |user|
      if current_user.name == user[0]
        @rank = num + 1
      end
      num = num + 1
    end
  end

  # PUT /resource
  def update
    @user = current_user
    if params[:point].present?
       @point = @user.point
       @user.update(point: @point + params[:point].to_i)
    else
      if @user.update(user_params)
        bypass_sign_in(@user)
        redirect_to root_path, flash: { success: 'ユーザー情報を編集しました！'}
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end


end
