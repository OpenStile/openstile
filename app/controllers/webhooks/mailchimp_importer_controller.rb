module Webhooks
  class MailchimpImporterController < ApplicationController
    skip_before_action :verify_authenticity_token

    def subscribe
      new_profile = InterestSwiperQuiz::Profile.find_or_create_by(email: params[:data]['email'],
                                                                  first_name: params[:data]['merges']['FNAME'],
                                                                  last_name: params[:data]['merges']['LNAME'])

      if new_profile.valid?
        ShopperMailer.invite_shopper_interest(new_profile.first_name, new_profile.email).deliver
      end

      render json: {status: :ok}
    end

    def validate
      render json: {status: :ok}
    end
  end
end