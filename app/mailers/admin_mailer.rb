class AdminMailer < ActionMailer::Base
  default from: "OpenStile <info@openstile.com>"

  def referral_submitted referral_hash
    @referral = RetailerReferral.new(referral_hash)
    mail to: User.admins.map(&:email),
         subject: "OpenStile referral: #{@referral.store_name}"
  end

  def drop_in_scheduled drop_in
    @drop_in = drop_in
    mail to: User.admins.map(&:email),
         subject: "#{drop_in.user.first_name} has booked an OpenStile style session"
  end
end
