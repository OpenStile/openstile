class RetailUserMailer < ActionMailer::Base
  default from: "OpenStile <info@openstile.com>"
  layout 'mailer'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.drop_in_scheduled_mailer.email.subject
  #
  def drop_in_scheduled_email(drop_in)
    @styling = drop_in
    attachments['styling.ics'] = drop_in.ics_attachment(:retailer).to_ical
    mail to: drop_in.retailer.user.email, subject: "#{drop_in.user.first_name} has scheduled a styling with you"
  end

  def drop_in_canceled_email(drop_in)
    @styling = drop_in
    mail to: drop_in.retailer.user.email, subject: "#{drop_in.user.first_name} has canceled a styling with you"
  end
end
