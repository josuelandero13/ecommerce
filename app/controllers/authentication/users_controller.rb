# frozen_string_literal: true

# User authentication driver
class Authentication::UsersController < ApplicationController
  skip_before_action :protect_pages

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.country = FetchCountryService.new(
      request.remote_ip
    ).fetch_country_code

    create_redirection_params
  end

  private

  def user_params
    params.require(:user).permit(:email, :username, :password)
  end

  def create_redirection_params
    return render :new, status: :unprocessable_entity unless @user.save

    UserMailer.with(user: @user).welcome.deliver_later
    session[:user_id] = @user.id
    redirect_to products_path, notice: t('.created')
  end
end
