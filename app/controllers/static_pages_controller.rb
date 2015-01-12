class StaticPagesController < ApplicationController

  skip_filter :authenticate_shopper!
  
  def home
    if shopper_signed_in?
      @recommendations = process_recommendations current_shopper  
    end
  end

  def about
  end

  def retailer_info
  end

  def blog
  end
end
