module Favoriteable
  extend ActiveSupport::Concern

  included do
    before_filter :store_shopper_location, only: [:toggle_favorite]
    before_filter :authenticate_shopper!, only: [:toggle_favorite]
  end

  def toggle_favorite
    klass = params[:controller].singularize.capitalize.constantize
    @item = klass.find(params[:id])
    if @item.interested_shoppers.include? current_shopper
      current_shopper.favorites.find_by(favoriteable: @item).destroy
    else
      current_shopper.favorites.create(favoriteable: @item)
    end

    respond_to do |format|
      format.html { render 'shared/item' }
      format.js { render 'shared/toggle_favorite' }
    end
  end
end
