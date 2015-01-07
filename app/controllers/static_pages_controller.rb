class StaticPagesController < ApplicationController

  skip_filter :authenticate_shopper!
  
  def home
  end

  def about
  end

  def retailer_info
  end

  def blog
  end
end
