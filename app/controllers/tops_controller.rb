class TopsController < ApplicationController
  def show
    @top = Top.find(params[:id])
    store_recommendation_show_url
  end
end
