require 'rails_helper'

feature 'Retail user manages drop in schedule' do
  let(:shopper){ FactoryGirl.create(:shopper) }
  let(:retailer){ FactoryGirl.create(:retailer) }
  let(:retail_user){ FactoryGirl.create(:retail_user, retailer: retailer) }
  let(:next_week){ DateTime.current.advance(days: 7).to_date.to_s }
  let(:morning){ "09:00:00" }
  let(:noon){ "12:00:00" }
  let(:evening){ "17:00:00" }

  scenario 'turns on drop-ins for a day' do
    baseline_calibration_for_shopper_and_retailers

    given_shopper_fails_to_schedule_drop_in next_week, noon
    given_i_am_a_logged_in_retail_user retail_user
    when_i_go_to_manage_my_store_drop_in_availability
    when_i_submit_with_invalid_options
    then_my_availability_should_not_be_updated
    when_i_set_my_drop_in_availability_with_valid_options next_week, morning, evening
    then_shopper_succeeds_to_schedule_drop_in next_week, noon
  end

  def given_shopper_fails_to_schedule_drop_in date, time
    given_i_am_a_logged_in_shopper shopper
    when_i_select_a_recommendation retailer

    within(:css, "div.schedule") do
      fill_in 'Date', with: date
      fill_in 'Time', with: time

      click_button 'Schedule'
    end

    expect(page).to have_content('not an available time slot')
  end

  def when_i_go_to_manage_my_store_drop_in_availability
    click_link 'Dashboard'
    click_link 'Manage your drop-in availability'
    expect(page).to have_content('Drop-in Availability')
  end

  def when_i_submit_with_invalid_options
    click_button 'Add'
  end

  def then_my_availability_should_not_be_updated
    expect(page).to have_content('Drop-in Availability')
    expect(page).to have_content('There was an error')
  end

  def when_i_set_my_drop_in_availability_with_valid_options date, start_time, end_time
    fill_in 'Date', with: date
    choose 'status_on'
    select 'One-time', from: 'Frequency'
    fill_in 'Start', with: start_time
    fill_in 'End', with: end_time
    select '2 at a time', from: 'How many shoppers can you handle?'

    click_button 'Add'

    expect(page).to have_content('Your drop-in availability has been updated')
  end

  def then_shopper_succeeds_to_schedule_drop_in date, time
    given_i_am_a_logged_in_shopper shopper
    when_i_select_a_recommendation retailer

    within(:css, "div.schedule") do
      fill_in 'Date', with: date
      fill_in 'Time', with: time

      click_button 'Schedule'
    end

    expect(page).to have_content('Your drop-in was scheduled!')
  end

  private
    def baseline_calibration_for_shopper_and_retailers
      shared_size = FactoryGirl.create(:top_size)
      shopper.style_profile.top_sizes << shared_size
      retailer.top_sizes << shared_size

      retailer.create_price_range!(top_min_price: 50.00, top_max_price: 100.00)
    end
end
