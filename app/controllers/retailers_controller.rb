class RetailersController < ApplicationController
  def show
    @retailer = Retailer.find(params[:id])
    store_recommendation_show_url
  end

  def enable_available_dates
    @available_dates = Retailer.find(params[:id]).get_available_drop_in_dates(true)
    respond_to do |format|
      format.js {}
    end
  end

  def enable_available_times
    @available_times = Retailer.find(params[:id])
                               .get_available_drop_in_times(params[:date])
    respond_to do |format|
      format.js {}
    end
  end

  def show_drop_in_location
    @location = Retailer.find(params[:id])
                        .get_drop_in_location(params[:date]).stringify
    respond_to do |format|
      format.js {}
    end
  end
end
