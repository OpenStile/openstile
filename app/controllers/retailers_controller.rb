class RetailersController < ApplicationController
  def show
    @retailer = params[:id]
  end
end
