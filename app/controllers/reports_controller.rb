class ReportsController < ApplicationController
  include ReportsHelper

  before_filter :authenticate_user!
  before_filter :authenticate_admin_user!

  def new
  end

  def create
    report_start = Date.parse(params[:start]).at_beginning_of_day
    report_end = Date.parse(params[:end]).at_end_of_day

    render json: {"Activation" => shoppers_created_between(report_start, 
                                                           report_end).count,
                  "Retention" => new_shoppers_logged_back_in_between(report_start, 
                                                                     report_end).count,
                  "Revenue" => new_shoppers_booked_drop_in_between(report_start, 
                                                                   report_end).count}
  end
end
