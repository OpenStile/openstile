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
    when_i_set_my_store_drop_in_availability next_week, morning, evening
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

  def when_i_set_my_store_drop_in_availability date, start_time, end_time
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

      shopper.style_profile.budget.update!(top_min_price: 50.00, top_max_price: 100.00)
      retailer.price_range.update!(top_min_price: 50.00, top_max_price: 100.00)
    end
end
