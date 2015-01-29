class BottomsController < ApplicationController
  def show
    @bottom = Bottom.find(params[:id])
    store_recommendation_show_url
  end
end
