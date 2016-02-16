require 'rails_helper'

feature 'OpenStile sends styling session reminders' do
  let(:shopper){ FactoryGirl.create(:shopper_user) }
  let(:retailer){ FactoryGirl.create(:retailer) }
  let!(:drop_in_availability) {
    FactoryGirl.create(:drop_in_availability,
                       retailer: retailer,
                       template_date: 1.day.ago,
                       start_time: '00:00:00',
                       end_time: '23:59:59',
                       frequency: DropInAvailability::DAILY_FREQUENCY,
                       bandwidth: 2,
                       location: retailer.location)
  }
  let!(:retail_user){ FactoryGirl.create(:retailer_user, retailer: retailer) }

  scenario '30 min prior to session', perform_enqueued: true do
    #perform_enqueued should be updated to test that email actually sent 30 min out
    FactoryGirl.create(:drop_in,
                       user: shopper,
                       retailer: retailer,
                       time: Time.zone.now + 1802.seconds)

    given_i_wait 2.seconds
    then_reminder_emails_should_be_sent_out :before
  end

  scenario '30 min prior unless session is canceled', perform_enqueued: true do
    #perform_enqueued should be updated to test that created drop ins later canceled don't generate reminders
    FactoryGirl.create(:drop_in,
                       user: shopper,
                       retailer: retailer,
                       status: DropIn::CANCELED_STATE,
                       time: Time.zone.now + 1802.seconds)

    given_i_wait 2.seconds
    then_reminder_emails_should_not_be_sent :before
  end

  def given_i_wait amount
    sleep(amount)
  end

  def given_the_shopper_cancels_the_styling
    given_i_am_a_logged_in_user shopper
    click_link 'cancel'
    expect(page).to have_content('Your styling session has been canceled')
  end

  def then_reminder_emails_should_be_sent_out reminder_type
    latest = ActionMailer::Base.deliveries[-2..-1]
    recipients = latest.map(&:to).flatten
    subjects = latest.map(&:subject)

    expect(recipients).to include(shopper.email)
    expect(recipients).to include(retail_user.email)

    if reminder_type == :before
      expect(subjects).to include("Your styling with #{retailer.name} is in 30 minutes")
      expect(subjects).to include("Your styling with #{shopper.first_name} is in 30 minutes")
    end
  end

  def then_reminder_emails_should_not_be_sent reminder_type
    latest = ActionMailer::Base.deliveries[-2..-1]
    subjects = latest.map(&:subject)

    if reminder_type == :before
      expect(subjects).to_not include("Your styling with #{retailer.name} is in 30 minutes")
      expect(subjects).to_not include("Your styling with #{shopper.first_name} is in 30 minutes")
    end
  end
end