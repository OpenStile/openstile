class DropInsController < ApplicationController

  before_filter :authenticate_shopper!

  def create
    @drop_in = DropIn.new(drop_in_params)

    if @drop_in.save 
    else
      @retailer = Retailer.find_by_id(drop_in_params[:retailer_id])
      if @retailer 
        render 'retailers/show'
      else
        flash.now[:danger] = "There was an unexpected error scheduling your drop-in."
        render 'static_pages/home'
      end
    end
  end

  private
    def drop_in_params
      params.require(:drop_in).permit(:shopper_id, :retailer_id, :comment)
    end
end
