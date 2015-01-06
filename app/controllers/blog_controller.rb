class BlogController < ApplicationController

  skip_before_filter :authenticate_shopper!

  def index
  end

  def blog_01
  end

  def blog_02
  end

  def blog_03
  end
end
