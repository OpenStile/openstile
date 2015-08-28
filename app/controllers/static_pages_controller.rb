class StaticPagesController < ApplicationController

  before_filter :go_to_relaunch, :only => [:home]
  skip_filter :authenticate_shopper!
  
  def home
    if shopper_signed_in?
      @retailers, @features = process_recommendations current_shopper
    end
  end

  def about
  end

  def retailer_info
  end

  def blog
  end

  def experience
  end

  def relaunch
  end

  def decal
    response.headers.delete('X-Frame-Options')
    @retailer = Retailer.find(params[:retailer_id])
  end
end
