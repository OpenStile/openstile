class Users::UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authenticate_admin_user!

  def shoppers
    @shoppers = User.shoppers.order(created_at: :desc)
  end
end