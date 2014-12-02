class ShoppersController < ApplicationController
  def new
    @shopper = Shopper.new
  end

  def create
    @shopper = Shopper.new(user_params)
    if @shopper.save
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:shopper).permit(:first_name, :email, :password, 
                                      :password_confirmation)
    end
end
