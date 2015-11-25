class StyleProfilesController < ApplicationController

  before_filter :store_shopper_location
  before_filter :authenticate_user!
  before_action :correct_style_profile_shopper

  def edit
  end

  def update
    if @style_profile.update_attributes(style_profile_params)
      flash[:success] = "Your Style Profile has been updated!"
      attempted_booking = retrieve_signed_out_booking true
      if attempted_booking
        redirect_to retailer_path Retailer.find(attempted_booking['retailer_id'])
      else
        redirect_to upcoming_drop_ins_path
      end
    else
      flash[:danger] = "Whoops! Something went wrong. Please try again"
      render "edit"
    end
  end

  private
    
    def correct_style_profile_shopper
      @style_profile = StyleProfile.find(params[:id])
      unless current_user.user_role.name == UserRole::SHOPPER && @style_profile.user == current_user
          redirect_to root_path
      end
    end

    def style_profile_params
      params.fetch(:style_profile, {}).permit(:body_shape_id, :top_fit_id, :bottom_fit_id,
                                            :top_budget, :bottom_budget, :dress_budget, look_ids: [],
                                            top_size_ids: [], bottom_size_ids: [], dress_size_ids: [], body_build_ids: [],
                                            flaunted_part_ids: [], downplayed_part_ids: [],
                                            avoided_color_ids: [], special_consideration_ids: [])
    end
end
