class StyleProfilesController < ApplicationController

  before_filter :authenticate_shopper!
  before_action :correct_style_profile_shopper

  def edit
  end

  private
    
    def correct_style_profile_shopper
      @style_profile = StyleProfile.find(params[:id])
      redirect_to root_url unless (@style_profile.shopper == current_shopper)
    end
end
