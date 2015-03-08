class DressesController < ApplicationController
  include Favoriteable
  before_filter :authenticate_admin!, only: [:new, :create]

  def show
    @dress = Dress.find(params[:id])
    store_recommendation_show_url
  end

  def new
    @dress = Retailer.find(params[:retailer_id]).dresses.build
  end

  def create
    @dress = Dress.new(dress_params)
    if @dress.save
      flash[:success] = "Dress added to catalog"
      redirect_to catalog_retailer_path(@dress.retailer) 
    else
      render 'new'
    end
  end

  private

  def dress_params
    params.require(:dress).permit(:name, :description, :price, :web_link, :look_id, 
                     :retailer_id, :print_id, :color_id, :body_shape_id, 
                     :for_petite, :for_tall, :for_full_figured, :top_fit_id,
                     :bottom_fit_id, dress_size_ids: [], special_consideration_ids: [])  
  end
end
