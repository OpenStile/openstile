class ShopperMailer < ActionMailer::Base
  include Roadie::Rails::Automatic

  default from: "no-reply@openstile.com", css: 'style.css'

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
    # @stylesheets = %w[/assets/stylesheets/style.css.scss]
    # attachments.inline['empty_hangers'] = {
    #                             :content => File.read("#{Rails.root.to_s + '/app/assets/images/empty_hangers.jpg'}"),
    #                             :mime_type => "image/jpg"
    #                           }
    mail to: @shopper.email, subject: "#{@retailer.name} is expecting you #{@drop_in.colloquial_time}"
  end

  def drop_in_canceled_email(retailer, shopper, drop_in)
    @retailer = retailer
    @greeting = "Hello #{shopper.first_name}"
    @shopper = shopper
    @drop_in = drop_in
    mail to: @shopper.email, subject: "Your drop-in for #{@drop_in.colloquial_time} at #{@retailer.name} has been canceled"
  end

  def drop_in_reminder_email(retailer, shopper, drop_in )
    @retailer = retailer
    @greeting = "Hello #{shopper.first_name}"
    @shopper = shopper
    @drop_in = drop_in
    mail to: @shopper.email, subject: "Reminder - You have an upcoming drop-in at #{@retailer.name}"
  end
end
