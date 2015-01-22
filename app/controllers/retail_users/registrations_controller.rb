class RetailUsers::RegistrationsController < Devise::RegistrationsController

skip_before_filter :authenticate_retail_user!, :only => [:new,:create]

  # GET /resource/sign_up
  # def new
  #   @retail_user = RetailUser.new
  # end

  # POST /resource
  # def create
  #   @retail_user = RetailUser.new(user_params)
  #   if @retail_user.save
  #     sign_in(@retail_user)
  #     redirect_to root_path
  #   else
  #     render 'new'
  #   end
  # end

  private

  def user_params
    params.require(:retail_user).permit(:first_name, :email, :cell_phone,
                                    :password, :password_confirmation)
  end
end
