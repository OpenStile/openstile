class ReferralMailer < ActionMailer::Base
  default from: "OpenStile <info@openstile.com>"
  layout 'mailer'

  def referral_submitted referral_hash
    @referral = RetailerReferral.new(referral_hash)
    mail to: @referral.referrer_email, subject: 'Thanks for the OpenStile referral!'
  end
end
