class StaticPagesController < ApplicationController

  before_filter :go_to_relaunch, :only => [:about, :experience]
  skip_filter :authenticate_shopper!
  
  def home
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

  def join_confirmation
  end

  def decal
    response.headers.delete('X-Frame-Options')
    @retailer = Retailer.find(params[:retailer_id])
  end
end
