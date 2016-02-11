class ShopperMailer < ActionMailer::Base
  default from: "OpenStile <info@openstile.com>"
  layout 'mailer'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.drop_in_scheduled_mailer.email.subject
  #
  def drop_in_scheduled_email(drop_in)
    @styling = drop_in
    attachments['styling.ics'] = @styling.ics_attachment(:shopper).to_ical
    mail to: @styling.user.email, subject: "You have scheduled a styling with #{@styling.retailer.name}!"
  end

  def drop_in_canceled_email(drop_in)
    @styling = drop_in
    mail to: drop_in.user.email, subject: "You have canceled your styling with #{drop_in.retailer.name}"
  end
end
