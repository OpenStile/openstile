class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include RecommendationsHelper
  include ItemsHelper

  devise_group :customer, contains: [:shopper, :retail_user]
  devise_group :catalog_reviewer, contains: [:retail_user, :admin]


  before_filter :update_last_shopper_sign_in_at

  protected
    def update_last_shopper_sign_in_at
      if shopper_signed_in? && !session[:logged_signin]
        sign_in(current_shopper, :force => true)
        session[:logged_signin] = true 
      end
    end
end
