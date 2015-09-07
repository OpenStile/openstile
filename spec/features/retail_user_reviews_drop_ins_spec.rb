require 'rails_helper'

feature 'Retail user reviews drop in' do
  let(:retailer){ FactoryGirl.create(:retailer) }
  let(:retail_user){ FactoryGirl.create(:retail_user, retailer: retailer) }
  let(:shopper){ FactoryGirl.create(:shopper, first_name: 'Jane') }
  let(:hourglass){ FactoryGirl.create(:body_shape, name: 'Hourglass') }
  let(:top){ FactoryGirl.create(:top, retailer: retailer) }
  let!(:drop_in_availability) { 
    FactoryGirl.create(:standard_availability_for_tomorrow,
                       retailer: retailer)
  }
  let!(:drop_in) {
    FactoryGirl.create(:drop_in,
                       shopper: shopper,
                       retailer: retailer,
                       comment: 'I really need stuff for my Miami vacay',
                       time: ActiveSupport::TimeZone[Time.zone.name]
                                .parse("#{1.day.from_now.change(hour: 10).to_s}"))
  }
  let!(:drop_in_item) { FactoryGirl.create(:drop_in_item, 
                                           drop_in: drop_in, 
                                           reservable: top) }

  scenario 'that has yet to occur' do
    shopper.style_profile.update(body_shape: hourglass)

    given_i_am_a_logged_in_retail_user retail_user
    when_i_view_my_upcoming_drop_ins
    then_i_should_see_a_scheduled_drop_in_for_shopper shopper.first_name, 'Tomorrow @ 10 AM'
    then_i_should_see_addtional_drop_in_comments drop_in
    then_i_should_see_a_synopsis_for_shopper "hourglass shape"
    then_i_should_see_items_of_interest_for_shopper top
  end

  def when_i_view_my_upcoming_drop_ins
    click_link 'My appointments'

    expect(page).to have_content('My Drop-Ins')
  end

  def then_i_should_see_a_scheduled_drop_in_for_shopper name, date_and_time
    expect(page).to have_content(name)
    expect(page).to have_content(date_and_time)
  end

  def then_i_should_see_addtional_drop_in_comments appointment
    expect(page).to have_content(appointment.comment)
  end

  def then_i_should_see_a_synopsis_for_shopper preference 
    expect(page).to have_content(preference)
  end

  def then_i_should_see_items_of_interest_for_shopper item
    expect(page).to have_link(item.image_alt_text)
  end
end
