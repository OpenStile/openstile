class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include UsersHelper

  devise_group :customer, contains: [:shopper, :retail_user]

  before_filter :update_last_shopper_sign_in_at

  protected
    def authenticate_admin_user!
      if user_signed_in? && current_user.user_role.name != UserRole::ADMIN
        redirect_to root_path
      end
    end

    def authenticate_retailer_user!
      if user_signed_in? && current_user.user_role.name != UserRole::RETAILER
        redirect_to root_path
      end
    end

    def go_to_relaunch
      redirect_to relaunch_path if ENV['OST_RELAUNCH_PREP']
    end

    def update_last_shopper_sign_in_at
      if user_signed_in? && current_user.user_role.name == UserRole::SHOPPER && !session[:logged_signin]
        sign_in(current_user, :force => true)
        session[:logged_signin] = true 
      end
    end

    def store_shopper_location
      # store last url - this is needed for post-login redirect to whatever the user last visited.
      return unless request.get?
      if (request.path != "/users/sign_in" &&
          request.path != "/users/sign_up" &&
          request.path != "/users/password/new" &&
          request.path != "/users/password/edit" &&
          request.path != "/users/confirmation" &&
          request.path != "/users/sign_out" &&
          !request.xhr?) # don't store ajax calls
        session[:previous_url] = request.fullpath 
      end
    end

    def store_signed_out_booking params
      session[:attempted_booking] = params
    end

    def retrieve_signed_out_booking soft=false
      if soft
        return session[:attempted_booking]
      else
        return session.delete(:attempted_booking)
      end
    end

    def store_signed_out_style_profile params
      session[:stashed_style_profile] = params
    end

    def retrieve_signed_out_style_profile
      session.delete(:stashed_style_profile)
    end
end
