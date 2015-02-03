require 'rails_helper'

feature 'Retail user reviews drop in' do
  let(:retailer){ FactoryGirl.create(:retailer) }
  let(:retail_user){ FactoryGirl.create(:retail_user, retailer: retailer) }
  let(:shopper){ FactoryGirl.create(:shopper, first_name: 'Jane') }
  let(:top){ FactoryGirl.create(:top, retailer: retailer) }
  let!(:drop_in_availability) { 
    FactoryGirl.create(:drop_in_availability,
                       retailer: retailer,
                       start_time: tomorrow_morning,
                       end_time: tomorrow_evening)
  }
  let!(:drop_in) {
    FactoryGirl.create(:drop_in,
                       shopper: shopper,
                       retailer: retailer,
                       time: DateTime.current.advance(days: 1).change(hour: 10))
  }

  scenario 'that has yet to occur' do
    given_i_am_a_logged_in_retail_user retail_user
    when_i_view_my_upcoming_drop_ins
    then_i_should_see_a_scheduled_drop_in_for_shopper shopper.first_name, 'Tomorrow @ 10AM'
    then_i_should_see_a_synopsis_for_shopper shopper
  end

  def given_i_am_a_logged_in_retail_user retail_user
    visit '/'
    click_link 'Log in'
    click_link 'Are you a retailer?'
    fill_in 'Email', with: retail_user.email
    fill_in 'Password', with: retail_user.password
    click_button 'Log in'
  end

  def when_i_view_my_upcoming_drop_ins
    click_link 'View your scheduled drop-ins'

    expect(page).to have_content('Scheduled Drop-ins')
  end

  def then_i_should_see_a_scheduled_drop_in_for_shopper name, date_and_time
    expect(page).to have_content("#{name} is coming in #{date_and_time}")
  end

  def then_i_should_see_a_synopsis_for_shopper shopper
    expect(page).to have_content(shopper.style_profile.synopsis)
  end
end
