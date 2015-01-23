require 'rails_helper'

feature 'Shopper schedule drop in' do
  let(:shopper){ FactoryGirl.create(:shopper) }
  let(:retailer){ FactoryGirl.create(:retailer) }

  scenario 'to browse a store' do
    baseline_calibration_for_shopper_and_retailers

    given_i_am_a_logged_in_shopper shopper
    when_i_select_a_recommendation retailer
    when_i_attempt_to_schedule_with_invalid_options retailer
    then_i_should_not_be_taken_to_my_scheduled_drop_ins
    when_i_attempt_to_schedule_with_valid_options
    then_my_scheduled_drop_ins_should_be_updated_with_retailer retailer
  end

  def when_i_select_a_recommendation recommendation
    visit '/'

    within(:css, "div#recommendation_#{recommendation.id}") do
      click_link 'Drop-in'
    end

    expect(page).to have_content(recommendation.description)
  end

  def when_i_attempt_to_schedule_with_invalid_options recommendation
    within(:css, "div.schedule") do
      click_button 'Schedule'
    end

    expect(page).to have_content('error')
    expect(page).to have_content(recommendation.description)
  end

  def then_i_should_not_be_taken_to_my_scheduled_drop_ins
    expect(page).to_not have_content('My Drop-Ins')
  end

  def when_i_attempt_to_schedule_with_valid_options
    skip
  end

  def then_my_scheduled_drop_ins_should_be_updated_with_retailer retailer
    skip
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
