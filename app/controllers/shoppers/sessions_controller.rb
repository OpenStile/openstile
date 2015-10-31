class Shoppers::SessionsController < Devise::SessionsController

  before_filter :go_to_relaunch, :only => [:new]

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

  def after_sign_in_path_for(shopper)
    session[:previous_url] || upcoming_drop_ins_path
  end
end
