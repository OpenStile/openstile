class RetailUserMailer < ActionMailer::Base
  default from: "no-reply@openstile.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.drop_in_scheduled_mailer.email.subject
  #
  def drop_in_scheduled_email(retailer, shopper, drop_in, recommendation)
    @retail_user = RetailUser.where(retailer_id: retailer.id).first
    @greeting = "Hello #{@retail_user.email}"
    @shopper = shopper
    @drop_in = drop_in
    unless recommendation.is_a? Retailer
      @recommendation = recommendation
    end
    mail to: @retail_user.email, subject: "#{@shopper.first_name} is coming in #{@drop_in.colloquial_time}"
  end

  def drop_in_canceled_email(retailer, shopper, drop_in)
    @retail_user = RetailUser.where(retailer_id: retailer.id).first
    @greeting = "Hello #{@retail_user.email}"
    @shopper = shopper
    @drop_in = drop_in
    mail to: @retail_user.email, subject: "#{@shopper.first_name} has canceled her drop-in for #{@drop_in.colloquial_time}"
  end

  def drop_in_reminder_email(retailer, shopper, drop_in )
    @retail_user = RetailUser.where(retailer_id: retailer.id).first
     @greeting = "Hello #{@retail_user.email}"
    @shopper = shopper
    @drop_in = drop_in
    mail to: @retail_user.email, subject: "Reminder - You have an upcoming drop-in with #{@shopper.first_name} #{@drop_in.colloquial_time}"
  end
end
