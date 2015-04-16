require 'rails_helper'

feature 'Shopper schedule drop in' do
  let(:shopper){ FactoryGirl.create(:shopper) }
  let(:retailer){ FactoryGirl.create(:retailer) }

  let(:top){ FactoryGirl.create(:top, retailer: retailer) }
  let(:bottom){ FactoryGirl.create(:bottom, retailer: retailer) }
  let(:dress){ FactoryGirl.create(:dress, retailer: retailer) }
  let(:outfit){ FactoryGirl.create(:outfit, retailer: retailer) }
  let(:pop_up_location){ FactoryGirl.create(:location,
                                  address: "1309 5th St. NE, Washington, DC 20002",
                                  neighborhood: "NoMa",
                                  short_title: "Crafty Bastards at Union Market") }
  let!(:drop_in_availability) {
    FactoryGirl.create(:standard_availability_for_tomorrow,
                       retailer: retailer,
                       location: pop_up_location)
  }
  let!(:retail_user){ FactoryGirl.create(:retail_user, retailer: retailer) }

  scenario 'to browse a store' do
    baseline_calibration_for_shopper_and_retailers

    date, time = parse_date_and_EST(tomorrow_afternoon)
    place = "Crafty Bastards at Union Market (1309 5th St. NE, Washington, DC 20002)"

    given_i_am_a_logged_in_shopper shopper
    given_i_have_no_drop_ins_scheduled
    when_i_click_on_the_suggested_retailer
    when_i_attempt_to_schedule_with_invalid_options retailer
    then_i_should_not_be_taken_to_my_scheduled_drop_ins
    when_i_attempt_to_schedule_with_valid_options date, time
    then_my_scheduled_drop_ins_should_be_updated_with retailer, "Tomorrow", place
    then_i_and_the_retail_user_should_receive_an_email retail_user.email, shopper.email 
  end

  scenario 'from the third party scheduler widget' do
    given_i_am_viewing_the_scheduler_widget_for retailer
    when_i_click_on_the_widget
    then_i_should_be_able_to_schedule_drop_in_upon_signin retailer
  end

  scenario 'to see a top' do
    baseline_calibration_for_shopper_and_items

    date, time = parse_date_and_EST(tomorrow_afternoon)
    place = "Crafty Bastards at Union Market (1309 5th St. NE, Washington, DC 20002)"

    given_i_am_a_logged_in_shopper shopper
    when_i_select_a_recommendation top
    when_i_attempt_to_schedule_with_invalid_options top
    then_i_should_not_be_taken_to_my_scheduled_drop_ins
    when_i_attempt_to_schedule_with_valid_options date, time
    then_my_scheduled_drop_ins_should_be_updated_with top.retailer, "Tomorrow", place
    then_i_and_the_retail_user_should_receive_an_email retail_user.email, shopper.email
    then_my_scheduled_should_show_item_on_hold top
  end

  scenario 'to see pants' do
    baseline_calibration_for_shopper_and_items

    date, time = parse_date_and_EST(tomorrow_afternoon)
    place = "Crafty Bastards at Union Market (1309 5th St. NE, Washington, DC 20002)"

    given_i_am_a_logged_in_shopper shopper
    when_i_select_a_recommendation bottom
    when_i_attempt_to_schedule_with_invalid_options bottom
    then_i_should_not_be_taken_to_my_scheduled_drop_ins
    when_i_attempt_to_schedule_with_valid_options date, time
    then_my_scheduled_drop_ins_should_be_updated_with bottom.retailer, "Tomorrow", place
    then_i_and_the_retail_user_should_receive_an_email retail_user.email, shopper.email
    then_my_scheduled_should_show_item_on_hold bottom
  end

  scenario 'to see a dress' do
    baseline_calibration_for_shopper_and_items

    date, time = parse_date_and_EST(tomorrow_afternoon)
    place = "Crafty Bastards at Union Market (1309 5th St. NE, Washington, DC 20002)"

    given_i_am_a_logged_in_shopper shopper
    when_i_select_a_recommendation dress
    when_i_attempt_to_schedule_with_invalid_options dress
    then_i_should_not_be_taken_to_my_scheduled_drop_ins
    when_i_attempt_to_schedule_with_valid_options date, time
    then_my_scheduled_drop_ins_should_be_updated_with dress.retailer, "Tomorrow", place
    then_i_and_the_retail_user_should_receive_an_email retail_user.email, shopper.email
    then_my_scheduled_should_show_item_on_hold dress
  end

  scenario 'to see an outfit' do
    baseline_calibration_for_shopper_and_outfits

    date, time = parse_date_and_EST(tomorrow_afternoon)
    place = "Crafty Bastards at Union Market (1309 5th St. NE, Washington, DC 20002)"

    given_i_am_a_logged_in_shopper shopper
    when_i_select_a_recommendation outfit
    when_i_attempt_to_schedule_with_invalid_options outfit
    then_i_should_not_be_taken_to_my_scheduled_drop_ins
    when_i_attempt_to_schedule_with_valid_options date, time
    then_my_scheduled_drop_ins_should_be_updated_with outfit.retailer, "Tomorrow", place
    then_my_scheduled_should_show_item_on_hold outfit
  end

  scenario 'to see an additional item' do
    baseline_calibration_for_shopper_and_items
    baseline_calibration_for_shopper_and_outfits

    existing_drop_in = FactoryGirl.create(:drop_in, shopper: shopper,
                                                    retailer: retailer,
                                                    time: tomorrow_afternoon)
    existing_drop_in_item = FactoryGirl.create(:drop_in_item,
                                               drop_in: existing_drop_in,
                                               reservable: top)

    given_i_am_a_logged_in_shopper shopper
    given_my_upcoming_drop_ins_page_contains existing_drop_in
    when_i_continue_browsing
    when_i_select_a_recommendation dress
    then_i_should_see_i_have_an_existing_drop_in_scheduled existing_drop_in
    when_i_add_item_to_existing_drop_in
    then_my_scheduled_should_show_item_on_hold top
    then_my_scheduled_should_show_item_on_hold dress
    when_i_continue_browsing   
    when_i_select_a_recommendation outfit
    then_i_should_see_i_have_an_existing_drop_in_scheduled existing_drop_in
    when_i_add_item_to_existing_drop_in
    then_my_scheduled_should_show_item_on_hold top
    then_my_scheduled_should_show_item_on_hold dress
    then_my_scheduled_should_show_item_on_hold outfit
  end

  def given_i_am_viewing_the_scheduler_widget_for retailer
    visit decal_path(retailer_id: retailer.id)
  end

  def when_i_click_on_the_widget
    find('a').click
  end

  def then_i_should_be_able_to_schedule_drop_in_upon_signin retailer
    date, time = parse_date_and_EST(tomorrow_afternoon)
    place = "Crafty Bastards at Union Market (1309 5th St. NE, Washington, DC 20002)"

    fill_in 'Email', with: shopper.email
    fill_in 'Password', with: shopper.password
    click_button 'Log in'
    expect(page).to have_content("Come see us at #{retailer.name} today!")

    when_i_attempt_to_schedule_with_valid_options date, time
    then_my_scheduled_drop_ins_should_be_updated_with retailer, "Tomorrow", place
  end

  def when_i_click_on_the_suggested_retailer
    click_link "retailer_logo"
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

      expect{click_button 'Schedule'}
            .to change(ActionMailer::Base.deliveries, :count).by(2) 
    end

    expect(page).to have_content('My Drop-Ins')
  end

  def then_my_scheduled_drop_ins_should_be_updated_with retailer, date, place
    expect(page).to have_content(retailer.name)
    expect(page).to have_content(date)
    expect(page).to have_content(place)
  end

  def then_my_scheduled_should_show_item_on_hold item
    expect(page).to have_content(item.name)
  end

  def when_i_continue_browsing
    click_link 'Continue Browsing'

    expect(page).to have_content('My Style Feed')
  end

  def then_i_should_see_i_have_an_existing_drop_in_scheduled appointment
    expect(page).to have_content('We see you have a drop-in')
    expect(page).to have_content(appointment.colloquial_time)
  end

  def when_i_add_item_to_existing_drop_in
    click_button 'Yes, I want to see this!'

    expect(page).to have_content('My Drop-Ins')
  end

  private
    def baseline_calibration_for_shopper_and_retailers
      shared_size = FactoryGirl.create(:top_size)
      shopper.style_profile.top_sizes << shared_size
      retailer.top_sizes << shared_size

      shopper.style_profile.budget.update!(top_min_price: 50.00, top_max_price: 100.00)
      retailer.create_price_range!(top_min_price: 50.00, top_max_price: 100.00)
    end

    def baseline_calibration_for_shopper_and_items
      shared_top_size = FactoryGirl.create(:top_size)
      shared_bottom_size = FactoryGirl.create(:bottom_size)
      shared_dress_size = FactoryGirl.create(:dress_size)

      shopper.style_profile.top_sizes << shared_top_size
      top.top_sizes << shared_top_size
      shopper.style_profile.bottom_sizes << shared_bottom_size
      bottom.bottom_sizes << shared_bottom_size
      shopper.style_profile.dress_sizes << shared_dress_size
      dress.dress_sizes << shared_dress_size

      shopper.style_profile.budget.update!(top_min_price: 50.00, top_max_price: 100.00,
                                     bottom_min_price: 50.00, bottom_max_price: 100.00,
                                     dress_min_price: 50.00, dress_max_price: 100.00)

      top.update!(price: 75.00)
      bottom.update!(price: 75.00)
      dress.update!(price: 75.00)
    end

    def baseline_calibration_for_shopper_and_outfits
      shared_top_size = FactoryGirl.create(:top_size)

      shopper.style_profile.top_sizes << shared_top_size
      outfit.top_sizes << shared_top_size

      shopper.style_profile.budget.update!(top_min_price: 50.00, top_max_price: 100.00,
                                     bottom_min_price: 50.00, bottom_max_price: 100.00,
                                     dress_min_price: 50.00, dress_max_price: 100.00)

      outfit.update!(average_price: 75.00)
    end

    def parse_date_and_EST datetime
      datetime_string = datetime.to_s
      zone = "Eastern Time (US & Canada)"
      est_datetime_string = ActiveSupport::TimeZone[zone]
                                          .parse(datetime_string).to_s

      est_datetime_string.split(' ').first(2)
    end
end
