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
    ical = create_ical_object drop_in, shopper, retailer
    attachments['event.ics'] = {:mime_type => 'text/calendar', :content => ical }
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

  private

  def create_ical_object drop_in, shopper, retailer
    # Create a calendar with an event (standard method)
    cal = Icalendar::Calendar.new
    cal.event do |e|
      e.dtstart     = Icalendar::Values::DateTime.new(drop_in.time)
      e.dtend       = Icalendar::Values::DateTime.new(drop_in.time + 30.minutes)
      e.location    = retailer.location.address
      e.summary     = "Drop-in visit with #{shopper.first_name}"
      e.description = "This is a reminder about the drop-in visit a shopper created on OpenStile. Here are the details:
        \n• Shopper: #{@shopper.first_name}"
      unless drop_in.comment.blank?
        e.description << "\n\n• Shopper comments: #{drop_in.comment}"
      end
      e.ip_class    = "PRIVATE"
    end

    cal.publish
    cal.to_ical
  end
end
