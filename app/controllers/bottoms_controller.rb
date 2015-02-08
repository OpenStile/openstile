class BottomsController < ApplicationController
  before_filter :authenticate_admin!, only: [:new, :create]

  def show
    @bottom = Bottom.find(params[:id])
    store_recommendation_show_url
  end

  def new
    @bottom = Retailer.find(params[:retailer_id]).bottoms.build
  end

  def create
    @bottom = Bottom.new(bottom_params)
    if @bottom.save
      flash[:success] = "Bottom added to catalog"
      redirect_to catalog_retailer_path(@bottom.retailer) 
    else
      render 'new'
    end
  end

  private

  def bottom_params
    params.require(:bottom).permit(:name, :description, :price, :web_link, :look_id, 
                            :retailer_id, :print_id, :color_id, :body_shape_id, 
                            :for_petite, :for_tall, :for_full_figured, :bottom_fit_id,
                            bottom_size_ids: [], special_consideration_ids: [])  
  end
end
