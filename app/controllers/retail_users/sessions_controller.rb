class RetailUsers::SessionsController < Devise::SessionsController

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    super
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  def after_sign_in_path_for(retail_user)
    root_path
  end
end