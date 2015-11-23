class DropInAvailabilitiesController < ApplicationController
  before_filter :authenticate_user!
  before_action :correct_retail_user, only: [:update]

  def personal
    @date = ''
    @drop_in_availability = DropInAvailability.new
  end

  def create
    @drop_in_availability = current_user
                             .retailer
                             .drop_in_availabilities
                             .build(drop_in_availability_params)

    if !destroy_drop_in_availability? && @drop_in_availability.save
      flash[:success] = "Your drop-in availability has been updated"
      redirect_to personal_drop_in_availabilities_path
    else
      flash[:danger] = "There was an error updating your availability. " +
                       "Please make sure you select a date, start time, and end time"
      redirect_to personal_drop_in_availabilities_path
    end
  end

  def update
    if destroy_drop_in_availability?
      if params[:update_focus] == 'series'
        @drop_in_availability.destroy
      elsif params[:update_focus] == 'single'
        @drop_in_availability.turn_off_date_in_series(drop_in_availability_params[:template_date])
      end
      flash[:success] = "Your drop-in availability has been updated"
      redirect_to personal_drop_in_availabilities_path
    elsif params[:update_focus] == 'series' &&
          @drop_in_availability.update(drop_in_availability_params)
      flash[:success] = "Your drop-in availability has been updated"
      redirect_to personal_drop_in_availabilities_path
    elsif params[:update_focus] == 'single' &&
          current_retail_user.retailer.drop_in_availabilities
                .create(drop_in_availability_params.merge(frequency: DropInAvailability::ONE_TIME_FREQUENCY))
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
      current_retail_user.retailer.get_relevant_availability(@date) || DropInAvailability.new
    respond_to do |format|
      format.js {}
    end
  end

  private
    def drop_in_availability_params
      params.require(:drop_in_availability).permit(:bandwidth, :frequency, :location_id, 
                                                   :template_date, :start_time, :end_time)
    end

    def destroy_drop_in_availability?
      params[:status] == "off"
    end

    def correct_retail_user
      @drop_in_availability = DropInAvailability.find(params[:id])
      unless (current_user.user_role.name == UserRole::RETAILER && @drop_in_availability.retailer.user == current_user)
        redirect_to root_path
      end
    end
end
