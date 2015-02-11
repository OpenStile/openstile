class RetailUserMailer < ActionMailer::Base
  default from: "no-reply@openstile.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.drop_in_scheduled_mailer.email.subject
  #
  def drop_in_scheduled_email(retailer, shopper, drop_in)
    @retail_user = RetailUser.where(retailer_id: retailer.id).first
    @greeting = "Hello #{@retail_user.email}"
    @shopper = shopper
    @drop_in = drop_in
    mail to: @retail_user.email, subject: 'An OpenStile shopper scheduled a drop-in visit with you!'
  end

  def drop_in_canceled_email(retailer, shopper, drop_in)
    @retail_user = RetailUser.where(retailer_id: retailer.id).first
    @greeting = "Hello #{@retail_user.email}"
    @shopper = shopper
    @drop_in = drop_in
    mail to: @retail_user.email, subject: 'An OpenStile shopper canceled a drop-in visit!'
  end
end
