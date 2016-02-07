class RetailerReferralsController < ApplicationController
  def create
    @retailers = Retailer.all_live
    @referral = RetailerReferral.new(referral_retailer_params)
    if @referral.valid?
      ReferralMailer.referral_submitted(@referral).deliver_now
      AdminMailer.referral_submitted(@referral).deliver_now unless User.admins.empty?
    end
    respond_to do |format|
      format.js {}
    end
  end

  def referral_retailer_params
    params.fetch(:retailer_referral, {}).permit(:referrer_name, :referrer_email, :store_name,
                                                :website, :contact_name, :contact_email)
  end
end