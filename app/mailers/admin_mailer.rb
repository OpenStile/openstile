class AdminMailer < ActionMailer::Base
  default from: "info@openstile.com"

  def referral_submitted referral
    @referral = referral
    mail to: User.admins.map(&:email),
         subject: "OpenStile referral: #{referral.store_name}"
  end
end
