class OutfitsController < ApplicationController
  
  def show
    @outfit = Outfit.find(params[:id])
    store_recommendation_show_url
  end

end
