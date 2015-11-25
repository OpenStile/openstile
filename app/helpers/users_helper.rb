module UsersHelper
  def shopper_signed_in?
    user_signed_in? && current_user.user_role.name == UserRole::SHOPPER
  end

  def retailer_signed_in?
    user_signed_in? && current_user.user_role.name == UserRole::RETAILER
  end

  def admin_signed_in?
    user_signed_in? && current_user.user_role.name == UserRole::ADMIN
  end
end