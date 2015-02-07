class RetailUsers::RegistrationsController < Devise::RegistrationsController

  before_filter :authenticate_retail_user!

# GET /resource/edit
  def edit
    super
  end

  # PUT /resource/
  def update
    if update_resource(current_retail_user, retail_user_password_update_params)
      flash[:success] = "Your Password has been updated!"
      sign_in(current_retail_user, :bypass => true)
      redirect_to root_url
    else
      render "edit"
    end
  end

  private

  def after_resetting_password_path_for(retail_user)
    root_path
  end

  def retail_user_password_update_params
    params.require(:retail_user).permit(:password, :password_confirmation, :current_password)
  end

end