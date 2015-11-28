class RetailersController < ApplicationController
  before_filter :go_to_relaunch, :only => [:index]
  before_filter :authenticate_user!, only: [:new, :create]
  before_filter :authenticate_admin_user!, only: [:new, :create]

  def show
    @retailer = Retailer.find(params[:id])
    attempted_booking = retrieve_signed_out_booking
    if attempted_booking && user_signed_in?
      @drop_in = current_user.drop_ins.build(attempted_booking)
    end
  end

  def index
    @retailers = Retailer.all
  end

  def new
    @retailer = Retailer.new
  end

  def create
    @retailer = Retailer.new(retailer_params)
    if @retailer.save
      flash[:success] = "Retailer created"
      redirect_to retailers_path
    else
      render 'new'
    end
  end

  def scheduled_availabilities
    @available_dates = Retailer.find(params[:id])
                        .get_available_drop_in_dates(:date_string, 
                                                     Time.zone.parse(params[:start]).to_date,
                                                     Time.zone.parse(params[:end]).to_date)
    respond_to do |format|
      format.json {}
    end
  end

  def enable_available_dates
    start_date = Date.current
    end_date = Date.current.advance(months: 2)
    @available_dates = Retailer.find(params[:id])
                               .get_available_drop_in_dates(:integer_array,
                                                            start_date,
                                                            end_date)
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

  private
    def retailer_params
      params.require(:retailer).permit(:name, :location_id, :description, 
                      :for_petite, :for_tall, :for_full_figured,
                      special_consideration_ids: [], top_size_ids: [], 
                      bottom_size_ids: [], dress_size_ids: [],
                      price_range_attributes: [:top_min_price, :top_max_price,
                                               :bottom_min_price, :bottom_max_price,
                                               :dress_min_price, :dress_max_price],
                      online_presence_attributes: [:web_link, :facebook_link, 
                                                   :instagram_link, :twitter_link])
    end

    def correct_retail_user
      @retailer = Retailer.find(params[:id])
      if retail_user_signed_in?
        redirect_to root_url unless @retailer == current_retail_user.retailer
      end
    end
end
