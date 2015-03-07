class DropInsController < ApplicationController

  before_filter :authenticate_shopper!, except: [:upcoming]
  before_filter :authenticate_customer!, only: [:upcoming]
  before_action :correct_drop_in_shopper, only: [:update, :destroy]

  def create
    retrieved_params = drop_in_params

    selected_date = retrieved_params.delete(:selected_date)
    selected_time = retrieved_params.delete(:selected_time)
    unless (selected_date.blank? || selected_time.blank?)
      datetime = ActiveSupport::TimeZone[Time.zone.name]
                    .parse("#{selected_date} #{selected_time}")
      retrieved_params[:time] = datetime
    end

    @drop_in = DropIn.new(retrieved_params)

    recommendation = retrieve_recommendation_object
    if @drop_in.save
      retailer = @drop_in.retailer
      RetailUserMailer.drop_in_scheduled_email(retailer, current_shopper, @drop_in).deliver
      ShopperMailer.drop_in_scheduled_email(retailer, current_shopper, @drop_in).deliver
      flash[:success] = "Your drop-in was scheduled! The retailer will be notified."
      redirect_to upcoming_drop_ins_path
    else
      if recommendation.is_a? Retailer
        @retailer = recommendation
        render 'retailers/show'
      elsif recommendation.is_a? Top
        @top = recommendation
        render 'tops/show'
      elsif recommendation.is_a? Bottom
        @bottom = recommendation
        render 'bottoms/show'
      elsif recommendation.is_a? Dress
        @dress = recommendation
        render 'dresses/show'
      elsif recommendation.is_a? Outfit
        @outfit = recommendation
        render 'outfits/show'
      else
        flash[:danger] = "There was an unexpected error scheduling your drop-in."
        redirect_to root_path
      end
    end
  end

  def update
    if @drop_in.update_attributes(drop_in_params)
      flash[:success] = "Your drop-in was updated! The retailer will be notified."
      redirect_to upcoming_drop_ins_path
    else
      flash[:danger] = "There was an unexpected error updating your drop-in."
      redirect_to root_path
    end
  end

  def destroy
    retailer = @drop_in.retailer
    RetailUserMailer.drop_in_canceled_email(retailer, current_shopper, @drop_in).deliver
    ShopperMailer.drop_in_canceled_email(retailer, current_shopper, @drop_in).deliver
    @drop_in.destroy
    flash[:success] = "Drop in cancelled. Retailer will be notified"
    redirect_to upcoming_drop_ins_path
  end

  def upcoming
    if shopper_signed_in?
      @drop_ins = DropIn.upcoming_for_shopper current_shopper.id
    elsif retail_user_signed_in?
      @drop_ins = DropIn.upcoming_for_retailer current_retail_user.retailer.id
    else
      flash[:danger] = "Unexpected error"
      redirect_to root_path
    end
  end

  private
    def correct_drop_in_shopper
      @drop_in = DropIn.find(params[:id])
      redirect_to root_url unless (@drop_in.shopper == current_shopper)
    end

    def drop_in_params
      params.require(:drop_in).permit(:shopper_id, :retailer_id, :comment,
                          :selected_date, :selected_time,
                          drop_in_items_attributes: [:reservable_id, :reservable_type])
    end
end
