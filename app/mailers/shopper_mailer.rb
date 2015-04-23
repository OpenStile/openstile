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

    ical = create_ical_object drop_in, retailer
    attachments['event.ics'] = {:mime_type => 'text/calendar', :content => ical }
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

  private

  def create_ical_object drop_in, retailer
    # Create a calendar with an event (standard method)
    cal = Icalendar::Calendar.new
    cal.event do |e|
      e.dtstart     = Icalendar::Values::DateTime.new(drop_in.time)
      e.dtend       = Icalendar::Values::DateTime.new(drop_in.time + 30.minutes)
      e.location    = retailer.location.address
      e.summary     = "Drop-in visit at #{retailer.name}"
      e.description = "This is a reminder for the drop-in visit you created on OpenStile. Here are the details:
        \n• Retailer: #{@retailer.name}
        \n• Adress: #{@retailer.location.address}
        \n• Phone Number: #{ActiveSupport::NumberHelper.number_to_phone(@retailer.phone_number)}"
      unless drop_in.comment.blank?
        e.description << "\n\n• Your comments: #{drop_in.comment}"
      end
      e.ip_class    = "PRIVATE"
    end

    cal.publish
    cal.to_ical
  end
end
