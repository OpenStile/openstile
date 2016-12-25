class ShopperMailer < ActionMailer::Base
  default from: "OpenStile <info@openstile.com>"
  layout 'mailer'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.drop_in_scheduled_mailer.email.subject
  #

  def invite_shopper_interest(first_name, email)
    @first_name = first_name
    @link = swipe_styles_new_url(token: Base64.encode64(email))
    mail to: email, subject: "Welcome to the OpenStile Beta"
  end

  def drop_in_scheduled_email(drop_in)
    @styling = drop_in
    attachments['styling.ics'] = @styling.ics_attachment(:shopper).to_ical
    mail to: @styling.user.email, subject: "You have scheduled a styling with #{@styling.retailer.name}!"
  end

  def drop_in_canceled_email(drop_in)
    @styling = drop_in
    mail to: drop_in.user.email, subject: "You have canceled your styling with #{drop_in.retailer.name}"
  end

  def upcoming_styling_reminder(drop_in)
    @styling = drop_in
    unless drop_in.canceled?
      mail to: drop_in.user.email, subject: "Your styling with #{drop_in.retailer.name} is in 30 minutes"
    end
  end

  def after_styling_reminder(drop_in)
    @styling = drop_in
    unless drop_in.canceled?
      mail to: drop_in.user.email, subject: "Review your styling with #{drop_in.retailer.name}"
    end
  end
end
