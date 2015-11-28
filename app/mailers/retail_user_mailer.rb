class RetailUserMailer < ActionMailer::Base
  default from: "info@openstile.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.drop_in_scheduled_mailer.email.subject
  #
  def drop_in_scheduled_email(retailer, shopper, drop_in)
    @shopper_name = shopper.first_name
    @owner_name = retailer.user.first_name
    @booking_time = drop_in.colloquial_time
    mail to: retailer.user.email, subject: "#{shopper.first_name} has scheduled a styling with you"
  end

  def drop_in_canceled_email(retailer, shopper, drop_in)
    @shopper_name = shopper.first_name
    @owner_name = retailer.user.first_name
    @booking_time = drop_in.colloquial_time
    mail to: retailer.user.email, subject: "#{shopper.first_name} has canceled a styling with you"
  end
end
