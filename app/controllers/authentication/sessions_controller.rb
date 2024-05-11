# frozen_string_literal: true

# User session controller
class Authentication::SessionsController < ApplicationController
  skip_before_action :protect_pages

  def new; end

  def create
    @user = User.find_by('email = :login OR username = :login', { login: params[:login] })

    create_redirection_params
  end

  def destroy
    session.delete(:user_id)

    redirect_to products_path, notice: t('.destroyed')
  end

  private

  def create_redirection_params
    authenticated_user = @user&.authenticate(params[:password])

    return redirect_to new_session_path, alert: t('.failed') unless authenticated_user

    session[:user_id] = @user.id
    redirect_to products_path, notice: t('.created')
  end
end
