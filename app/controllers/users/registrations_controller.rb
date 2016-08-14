class Users::RegistrationsController < Devise::RegistrationsController
# before_filter :configure_account_update_params, only: [:update]
  before_filter :configure_sign_up_params, only: [:create]
  before_filter :go_to_relaunch, :only => [:new]


# GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    @user = User.new(sign_up_params.merge(user_role: UserRole.find_by_name(UserRole::SHOPPER)))
    if @user.save
      sign_in @user
      flash[:success] = 'Your account has been successfully created! Check your email to confirm your account.'
      flash.keep(:success)
      render json: {location: upcoming_drop_ins_path}
    else
      render json: @user.errors.full_messages.uniq, status: :unprocessable_entity
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # You can put the params you want to permit in the empty array.
  def configure_sign_up_params
    devise_parameter_sanitizer.for(:sign_up) << :first_name
  end

  # You can put the params you want to permit in the empty array.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.for(:account_update) << :attribute
  # end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    path = root_path
    if current_user.user_role.name == UserRole::SHOPPER
      path = edit_style_profile_path(current_user.style_profile)
    end
    path
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
