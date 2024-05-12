# frozen_string_literal: true

# Driver for user profiles
class UsersController < ApplicationController
  skip_before_action :protect_pages, only: %i[show]

  def show
    @user = User.find_by!(username: params[:username])
    @pagy, @products = pagy_countless(
      FindProducts.new.call(
        { user_id: @user.id }
      ), items: 12
    )
  end
end
