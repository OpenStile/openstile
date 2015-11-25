class Users::SessionsController < Devise::SessionsController
# before_filter :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # You can put the params you want to permit in the empty array.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end

  def after_sign_in_path_for(resource)
    path = current_user.user_role.name == UserRole::SHOPPER ? upcoming_drop_ins_path : root_path
    attempted_booking = retrieve_signed_out_booking true
    if attempted_booking
      path = retailer_path Retailer.find(attempted_booking['retailer_id'])
    end
    path
  end
end
