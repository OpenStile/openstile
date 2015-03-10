class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include RecommendationsHelper
  include ItemsHelper

  devise_group :customer, contains: [:shopper, :retail_user]
  devise_group :catalog_reviewer, contains: [:retail_user, :admin]
end
