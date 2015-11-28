class ShopperMailer < ActionMailer::Base
  default from: "info@openstile.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.drop_in_scheduled_mailer.email.subject
  #
  def drop_in_scheduled_email(retailer, shopper, drop_in)
    @shopper_name = shopper.first_name
    @store_name = retailer.name
    @booking_time = drop_in.colloquial_time
    mail to: shopper.email, subject: "You have scheduled a styling with #{retailer.name}!"
  end

  def drop_in_canceled_email(retailer, shopper, drop_in)
    @shopper_name = shopper.first_name
    @store_name = retailer.name
    @booking_time = drop_in.colloquial_time
    mail to: shopper.email, subject: "You have canceled your styling with #{retailer.name}"
  end
end
