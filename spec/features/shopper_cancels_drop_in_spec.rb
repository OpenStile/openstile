require 'rails_helper'

feature 'Shopper modifies drop in' do
  let(:shopper){ FactoryGirl.create(:shopper_user) }
  let(:retailer){ FactoryGirl.create(:retailer) }
  let!(:retail_user){ FactoryGirl.create(:retailer_user, retailer: retailer) }
  let!(:drop_in_availability) {
    FactoryGirl.create(:standard_availability_for_tomorrow,
                       retailer: retailer,
                       location: retailer.location)
  }
  let!(:drop_in){ FactoryGirl.create(:drop_in,
                                     user: shopper,
                                     retailer: retailer,
                                     time: tomorrow_mid_morning) }

  scenario 'by cancelling it', perform_enqueued: true do
    given_i_am_a_logged_in_user shopper
    given_my_upcoming_drop_ins_page_contains drop_in
    given_my_drop_in_is_not_shown_as_canceled
    when_i_cancel_and_confirm drop_in
    then_my_upcoming_drop_ins_page_should_contain drop_in
    then_the_drop_in_should_be_shown_as_canceled
    then_i_and_the_retail_user_should_receive_an_email shopper.email, retail_user.email
    given_i_am_a_logged_in_user retail_user
    when_i_view_my_stylings
    then_the_drop_in_should_be_shown_as_canceled
  end

  def given_my_upcoming_drop_ins_page_contains appointment
    visit '/drop_ins/upcoming'

    expect(page).to have_link(appointment.retailer.name)
    expect(page).to have_content(appointment.colloquial_time)
  end

  def when_i_cancel_and_confirm appointment
    within(:css, "div#drop_in_#{appointment.id}") do
      click_link 'cancel'
    end
  end

  def then_my_upcoming_drop_ins_page_should_contain appointment
    visit '/drop_ins/upcoming'

    expect(page).to have_link(appointment.retailer.name)
  end

  def then_i_and_the_retail_user_should_receive_an_email shopper_email, retail_user_email
    last_two_receipients = ActionMailer::Base.deliveries[-2..-1]
                               .map(&:to).flatten
    last_two_subjects = ActionMailer::Base.deliveries[-2..-1]
                            .map(&:subject)
    expect(last_two_receipients).to include(retail_user_email)
    expect(last_two_receipients).to include(shopper_email)
    expect(last_two_subjects[0]).to match(/canceled (your|a) styling/)
    expect(last_two_subjects[1]).to match(/canceled (your|a) styling/)
  end

  def then_the_drop_in_should_be_shown_as_canceled
    expect(page).to have_text('CANCELED')
  end

  def given_my_drop_in_is_not_shown_as_canceled
    expect(page).to_not have_text('CANCELED')
  end

  def when_i_view_my_stylings
    click_link 'View my bookings'
  end
end
