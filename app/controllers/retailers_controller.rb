class RetailersController < ApplicationController
  def show
    @retailer = Retailer.find(params[:id])
  end

  def enable_available_dates
    @available_dates = Retailer.find(params[:id]).get_available_drop_in_dates(true)
    respond_to do |format|
      format.js {}
    end
  end
end
