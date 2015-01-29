class DressesController < ApplicationController
  def show
    @dress = Dress.find(params[:id])
    store_recommendation_show_url
  end
end
