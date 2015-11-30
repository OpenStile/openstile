class ReferralMailer < ActionMailer::Base
  default from: "info@openstile.com"

  def referral_submitted referral
    @referral = referral
    mail to: referral.referrer_email, subject: 'Thanks for the OpenStile referral!'
  end
end
