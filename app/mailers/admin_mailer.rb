class AdminMailer < ActionMailer::Base
  default from: "info@openstile.com"

  def referral_submitted referral
    @referral = referral
    mail to: User.where(user_role_id: UserRole.find_by_name(UserRole::ADMIN).id).map(&:email),
         subject: "OpenStile referral: #{referral.store_name}"
  end
end
