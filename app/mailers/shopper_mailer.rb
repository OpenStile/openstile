class ShopperMailer < ActionMailer::Base
  default from: "no-reply@openstile.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.drop_in_scheduled_mailer.email.subject
  #
  def drop_in_scheduled_email(retailer, shopper, drop_in)
    @retailer = retailer
    @greeting = "Hello #{shopper.first_name}"
    @shopper = shopper
    @drop_in = drop_in
    mail to: @shopper.email, subject: 'You have scheduled a drop-in visit with an OpenStile retailer!'
  end

  def drop_in_canceled_email(retailer, shopper, drop_in)
    @retailer = retailer
    @greeting = "Hello #{shopper.first_name}"
    @shopper = shopper
    @drop_in = drop_in
    mail to: @shopper.email, subject: 'You have canceled a drop-in visit with an OpenStile retailer!'
  end
end
