require 'rails_helper'

feature 'Shopper modifies drop in' do
  let(:shopper){ FactoryGirl.create(:shopper) }
  let(:retailer){ FactoryGirl.create(:retailer) }
  let!(:drop_in_availability) {
    FactoryGirl.create(:standard_availability_for_tomorrow,
                       retailer: retailer,
                       location: retailer.location)
  }
  let!(:drop_in){ FactoryGirl.create(:drop_in,
                                     shopper: shopper,
                                     retailer: retailer,
                                     time: tomorrow_mid_morning) }
  before do
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.deliveries = []
    @retail_user = retailer.create_retail_user(retailer_id: retailer.id,
                                              email: "john@example.com",
                                              password: "barbaz",
                                              password_confirmation: "barbaz")
  end

  scenario 'by cancelling it' do
    given_i_am_a_logged_in_shopper shopper
    given_my_upcoming_drop_ins_page_contains drop_in
    when_i_cancel_and_confirm drop_in
    then_my_upcoming_drop_ins_page_should_not_contain drop_in
    then_i_and_the_retail_user_should_receive_an_email
  end

  def when_i_cancel_and_confirm appointment
    within(:css, "div#drop_in_#{appointment.id}") do
      click_link 'cancel'
    end

    expect(page).to have_content('Drop in cancelled')
  end

  def then_my_upcoming_drop_ins_page_should_not_contain appointment
    click_link 'Drop-ins'

    expect(page).to_not have_content(appointment.retailer.name)
  end
end
