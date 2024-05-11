# frozen_string_literal: true

# User authentication driver
class Authentication::UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    return redirect_to products_path, notice: t('.created') if @user.save

    render :new, status: :unprocessable_entity
  end

  private

  def user_params
    params.require(:user).permit(:email, :username, :password)
  end
end
