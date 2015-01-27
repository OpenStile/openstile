require 'rails_helper'

feature 'Shopper schedule drop in' do
  let(:shopper){ FactoryGirl.create(:shopper) }
  let(:retailer){ FactoryGirl.create(:retailer) }
  let(:pop_up_location){ FactoryGirl.create(:location, 
                                  address: "1309 5th St. NE, Washington, DC 20002",
                                  neighborhood: "NoMa",
                                  short_title: "Crafty Bastards at Union Market") }
  let!(:drop_in_availability) { 
    FactoryGirl.create(:drop_in_availability,
                       retailer: retailer,
                       location: pop_up_location,
                       start_time: tomorrow_morning,
                       end_time: tomorrow_evening)
  }

  scenario 'to browse a store' do
    baseline_calibration_for_shopper_and_retailers

    date, time = parse_date_and_EST(tomorrow_afternoon)
    place = "Crafty Bastards at Union Market (1309 5th St. NE, Washington, DC 20002)"

    given_i_am_a_logged_in_shopper shopper
    when_i_select_a_recommendation retailer
    when_i_attempt_to_schedule_with_invalid_options retailer
    then_i_should_not_be_taken_to_my_scheduled_drop_ins
    when_i_attempt_to_schedule_with_valid_options date, time
    then_my_scheduled_drop_ins_should_be_updated_with retailer, "Tomorrow", place
  end

  def when_i_select_a_recommendation recommendation
    visit '/'

    within(:css, "div##{recommendation.class.to_s.downcase}_#{recommendation.id}") do
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

  def when_i_attempt_to_schedule_with_valid_options date, time
    within(:css, "div.schedule") do
      fill_in 'Date', with: date
      fill_in 'Time', with: time

      click_button 'Schedule'
    end

    expect(page).to have_content('My Drop-Ins')
  end

  def then_my_scheduled_drop_ins_should_be_updated_with retailer, date, place
    expect(page).to have_content(retailer.name)
    expect(page).to have_content(date)
    expect(page).to have_content(place)
  end

  private
    def baseline_calibration_for_shopper_and_retailers
      shared_size = FactoryGirl.create(:top_size)
      shopper.style_profile.top_sizes << shared_size
      retailer.top_sizes << shared_size

      shopper.style_profile.budget.update!(top_min_price: 50.00, top_max_price: 100.00)
      retailer.price_range.update!(top_min_price: 50.00, top_max_price: 100.00)
    end

    def parse_date_and_EST datetime
      datetime_string = datetime.to_s
      zone = "Eastern Time (US & Canada)"
      est_datetime_string = ActiveSupport::TimeZone[zone]
                                          .parse(datetime_string).to_s
        
      est_datetime_string.split(' ').first(2)
    end
end
