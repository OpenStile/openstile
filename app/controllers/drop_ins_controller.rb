class DropInsController < ApplicationController

  before_filter :store_shopper_location
  before_filter :authenticate_user!, except: [:create]
  before_action :correct_drop_in_customer, only: [:update]
  before_action :correct_drop_in_shopper, only: [:destroy, :cancel]

  def create
    retrieved_params = drop_in_params
    selected_date = retrieved_params.delete(:selected_date)
    selected_time = retrieved_params.delete(:selected_time)
    unless (selected_date.blank? || selected_time.blank?)
      datetime = ActiveSupport::TimeZone[Time.zone.name]
                    .parse("#{selected_date} #{selected_time}")
      retrieved_params[:time] = datetime
    end

    if retrieved_params[:user_id].blank?
      store_signed_out_booking retrieved_params.compact
      flash[:warning] = "Please log in or create an account so that we can save your booking."
      redirect_to new_user_session_path
    else
      @drop_in = DropIn.new(retrieved_params)

      if @drop_in.save
        retailer = @drop_in.retailer
        RetailUserMailer.drop_in_scheduled_email(@drop_in).deliver
        ShopperMailer.drop_in_scheduled_email(@drop_in).deliver
        AdminMailer.drop_in_scheduled(@drop_in).deliver unless User.admins.empty?
        flash[:success] = "Your drop-in was scheduled! The retailer will be notified."
        redirect_to upcoming_drop_ins_path
      else
        @retailer = @drop_in.retailer
        render 'retailers/show'
      end
    end
  end

  def update
    if @drop_in.update_attributes(drop_in_params)
      flash[:success] = "Your drop-in was updated!"
      redirect_to upcoming_drop_ins_path
    else
      flash[:danger] = "There was an unexpected error updating your drop-in."
      redirect_to root_path
    end
  end

  def destroy
    retailer = @drop_in.retailer
    RetailUserMailer.drop_in_canceled_email(@drop_in).deliver
    ShopperMailer.drop_in_canceled_email(@drop_in).deliver
    @drop_in.destroy
    flash[:success] = "Drop in cancelled. Retailer will be notified"
    redirect_to upcoming_drop_ins_path
  end

  def cancel
    RetailUserMailer.drop_in_canceled_email(@drop_in).deliver
    ShopperMailer.drop_in_canceled_email(@drop_in).deliver
    if @drop_in.update_attribute(:status, DropIn::CANCELED_STATE)
      flash[:success] = "Your styling session has been canceled. Retailer will be notified"
      redirect_to upcoming_drop_ins_path
    else
      flash[:danger] = "There was an unexpected error cancelling your styling session."
      redirect_to root_path
    end
  end

  def upcoming
    if current_user.user_role.name == UserRole::SHOPPER
      @previous_drop_ins = DropIn.previous_for_shopper current_user.id
      @upcoming_drop_ins = DropIn.upcoming_for_shopper current_user.id
    elsif current_user.user_role.name == UserRole::RETAILER
      @previous_drop_ins = DropIn.previous_for_retailer current_user.retailer.id
      @upcoming_drop_ins = DropIn.upcoming_for_retailer current_user.retailer.id
    else
      flash[:danger] = "Unexpected error"
      redirect_to root_path
    end
  end

  private
    def correct_drop_in_shopper
      @drop_in = DropIn.find(params[:id])
      redirect_to root_url unless (@drop_in.user == current_user && current_user.user_role.name == UserRole::SHOPPER)
    end

    def correct_drop_in_customer
      @drop_in = DropIn.find(params[:id])
      if current_user.user_role.name == UserRole::SHOPPER
        redirect_to root_url unless (@drop_in.user == current_user)
      elsif current_user.user_role.name == UserRole::RETAILER
        redirect_to root_url unless (@drop_in.retailer == current_user.retailer)
      else
        redirect_to root_url
      end
    end

    def drop_in_params
      params.require(:drop_in).permit(:user_id, :retailer_id, :comment,
                          :shopper_rating, :shopper_feedback, :sales_generated,
                          :retailer_rating, :retailer_feedback,
                          :selected_date, :selected_time)
    end
end
