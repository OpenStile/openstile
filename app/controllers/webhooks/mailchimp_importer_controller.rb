module Webhooks
  class MailchimpImporterController < ApplicationController
    skip_before_action :verify_authenticity_token

    def subscribe
      new_style_quiz = InterestSwiperQuiz::Session.find_or_create_by(email: params[:data]['email'],
                                                                     first_name: params[:data]['merges']['FNAME'],
                                                                     last_name: params[:data]['merges']['LNAME'])

      if new_style_quiz.valid?
        ShopperMailer.invite_shopper_interest(new_style_quiz.first_name, new_style_quiz.email).deliver
      end

      render json: {status: :ok}
    end

    def validate
      render json: {status: :ok}
    end
  end
end