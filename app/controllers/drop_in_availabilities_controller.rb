class DropInAvailabilitiesController < ApplicationController
  before_filter :authenticate_retail_user!

  def personal
    @date = ''
    @drop_in_availability = DropInAvailability.new
  end

  def create
    @drop_in_availability = current_retail_user
                             .retailer
                             .drop_in_availabilities
                             .build(drop_in_availability_params.merge(start_and_end_params))

    if @drop_in_availability.save
      flash[:success] = "Your drop-in availability has been updated"
      redirect_to personal_drop_in_availabilities_path
    else
      flash[:danger] = "There was an error updating your availability. " +
                       "Please make sure you select a date, start time, and end time"
      redirect_to personal_drop_in_availabilities_path
    end
  end

  def apply_form
    @date = params[:date]
    @drop_in_availability = 
      DropInAvailability.for_retailer_on_date(current_retail_user.retailer.id, @date) || DropInAvailability.new
    respond_to do |format|
      format.js {}
    end
  end

  private
    def drop_in_availability_params
      params.require(:drop_in_availability).permit(:bandwidth, :location_id)
    end

    def start_and_end_params
      ret = {}
      unless params[:date].blank? || params[:start_time].blank?
        ret[:start_time] = "#{params[:date]} #{params[:start_time]} -0500"
      end
      unless params[:date].blank? || params[:end_time].blank?
        ret[:end_time] = "#{params[:date]} #{params[:end_time]} -0500"
      end
      ret
    end
end
