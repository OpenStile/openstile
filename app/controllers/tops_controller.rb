class TopsController < ApplicationController
  include Favoriteable
  before_filter :authenticate_admin!, only: [:new, :create]

  def show
    @top = Top.find(params[:id])
    store_recommendation_show_url
  end

  def new
    @top = Retailer.find(params[:retailer_id]).tops.build
  end

  def create
    @top = Top.new(top_params)
    if @top.save
      flash[:success] = "Top added to catalog"
      redirect_to catalog_retailer_path(@top.retailer) 
    else
      render 'new'
    end
  end

  private

  def top_params
    params.require(:top).permit(:name, :description, :price, :web_link, :look_id, 
                                :retailer_id, :print_id, :color_id, :body_shape_id, 
                                :for_petite, :for_tall, :for_full_figured, :top_fit_id,
                                top_size_ids: [], special_consideration_ids: [])  
  end
end
