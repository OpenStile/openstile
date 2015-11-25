require 'rails_helper'

feature 'Shopper modifies drop in' do
  let(:shopper){ FactoryGirl.create(:shopper_user) }
  let(:retailer){ FactoryGirl.create(:retailer) }
  let!(:drop_in_availability) {
    FactoryGirl.create(:standard_availability_for_tomorrow,
                       retailer: retailer,
                       location: retailer.location)
  }
  let!(:drop_in){ FactoryGirl.create(:drop_in,
                                     user: shopper,
                                     retailer: retailer,
                                     time: tomorrow_mid_morning) }
  let!(:retail_user){ FactoryGirl.create(:retailer_user, retailer: retailer) }

  scenario 'by cancelling it' do
    given_i_am_a_logged_in_user shopper
    given_my_upcoming_drop_ins_page_contains drop_in
    when_i_cancel_and_confirm drop_in
    then_my_upcoming_drop_ins_page_should_not_contain drop_in
    then_i_and_the_retail_user_should_receive_an_email shopper.email, retail_user.email
  end

  def given_my_upcoming_drop_ins_page_contains appointment
    click_link 'logo-home'

    expect(page).to have_link(appointment.retailer.name)
    expect(page).to have_content(appointment.colloquial_time)
  end

  def when_i_cancel_and_confirm appointment
    within(:css, "div#drop_in_#{appointment.id}") do
      expect{click_link 'cancel'}
            .to change(ActionMailer::Base.deliveries, :count).by(2) 
    end

    expect(page).to have_content('Drop in cancelled')
  end

  def then_my_upcoming_drop_ins_page_should_not_contain appointment
    click_link 'logo-home'

    expect(page).to_not have_content(appointment.retailer.name)
  end
end
