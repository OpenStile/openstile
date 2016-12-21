require 'rails_helper'

feature 'Retail user manages drop in schedule' do
  let(:shopper){ FactoryGirl.create(:shopper_user) }
  let(:retailer){ FactoryGirl.create(:retailer) }
  let!(:retail_user){ FactoryGirl.create(:retailer_user, retailer: retailer) }
  let(:next_week){ DateTime.current.advance(days: 7).to_date.to_s }
  let(:morning){ "09:00:00" }
  let(:noon){ "12:00:00" }
  let(:evening){ "17:00:00" }

  scenario 'turns on drop-ins for a day' do
    given_shopper_fails_to_schedule_drop_in next_week, noon
    given_i_am_a_logged_in_user retail_user
    when_i_go_to_manage_my_store_drop_in_availability
    when_i_submit_with_invalid_options
    then_my_availability_should_not_be_updated
    when_i_set_my_drop_in_availability_with_valid_options next_week, morning, evening
    then_shopper_succeeds_to_schedule_drop_in next_week, noon
  end

  def given_shopper_fails_to_schedule_drop_in date, time
    given_i_am_a_logged_in_user shopper
    click_link 'Boutiques'
    click_link retailer.name

    within(:css, "div.schedule") do
      fill_in 'Date', with: date
      fill_in 'Time', with: time

      click_button 'Book session'
    end

    expect(page).to have_content('not an available time slot')
  end

  def when_i_go_to_manage_my_store_drop_in_availability
    visit '/drop_in_availabilities/personal'
    expect(page).to have_title('Drop-in Availability')
  end

  def when_i_submit_with_invalid_options
    click_button 'Add'
  end

  def then_my_availability_should_not_be_updated
    expect(page).to have_title('Drop-in Availability')
  end

  def when_i_set_my_drop_in_availability_with_valid_options date, start_time, end_time
    fill_in 'Date', with: date
    choose 'status_on'
    select 'One-time', from: 'Frequency'
    fill_in 'Start', with: start_time
    fill_in 'End', with: end_time
    select '2 at a time', from: 'How many shoppers can you handle?'

    click_button 'Add'
  end

  def then_shopper_succeeds_to_schedule_drop_in date, time
    given_i_am_a_logged_in_user shopper
    click_link 'Boutiques'
    click_link retailer.name

    within(:css, "div.schedule") do
      fill_in 'Date', with: date
      fill_in 'Time', with: time

      click_button 'Book session'
    end
  end
end
