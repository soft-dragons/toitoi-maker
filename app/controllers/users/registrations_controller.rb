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
    if params[:point].present?
       @user = current_user
       @point = @user.point
       @user.update(point: @point + params[:point].to_i)
    else
      @user = User.find(params[:id])
      if @user.update(customer_params)
    end
  end

  private
  # ストロングパラメータ
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end


end
