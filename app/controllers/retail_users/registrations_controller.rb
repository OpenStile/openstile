class RetailUsers::RegistrationsController < Devise::RegistrationsController

  before_filter :authenticate_retail_user!

# GET /resource/edit
  def edit
  end

  # PUT /resource/
  def update
    super
  end

  protected

  def after_resetting_password_path_for(retail_user)
    root_path
  end

end