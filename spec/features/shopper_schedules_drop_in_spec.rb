require 'rails_helper'

feature 'Shopper schedule drop in' do
  let(:shopper){ FactoryGirl.create(:shopper) }
  let(:retailer){ FactoryGirl.create(:retailer) }

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
    date, time = parse_date_and_EST(tomorrow_afternoon)
    place = "Crafty Bastards at Union Market (1309 5th St. NE, Washington, DC 20002)"

    given_i_am_a_logged_in_shopper shopper
    when_i_click_on_a_retailer retailer
    when_i_attempt_to_schedule_with_invalid_options retailer
    then_i_should_not_be_taken_to_my_scheduled_drop_ins
    when_i_attempt_to_schedule_with_valid_options date, time
    then_my_scheduled_drop_ins_should_be_updated_with retailer, "Tomorrow", place
    then_i_and_the_retail_user_should_receive_an_email retail_user.email, shopper.email 
  end

  scenario 'sign in from the third party scheduler widget' do
    given_i_am_viewing_the_scheduler_widget_for retailer
    when_i_click_on_the_widget
    then_i_should_be_able_to_schedule_drop_in_upon_signin retailer
  end

  scenario 'sign up from the third party scheduler widget' do
    given_i_am_viewing_the_scheduler_widget_for retailer
    when_i_click_on_the_widget
    then_i_should_be_able_to_schedule_drop_in_upon_signup retailer
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

  def then_i_should_be_able_to_schedule_drop_in_upon_signup retailer
    date, time = parse_date_and_EST(tomorrow_afternoon)
    place = "Crafty Bastards at Union Market (1309 5th St. NE, Washington, DC 20002)"

    click_link "Don't have an account? Join now."
    fill_in "First name", with: "Jane"
    fill_in "Email address", with: "jane@example.com"
    fill_in "Password", with: "foobarbaz"
    fill_in "Confirm password", with: "foobarbaz"
    click_button 'Sign up'
    expect(page).to have_content("Come see us at #{retailer.name} today!")

    when_i_attempt_to_schedule_with_valid_options date, time
    then_my_scheduled_drop_ins_should_be_updated_with retailer, "Tomorrow", place
  end

  def when_i_click_on_a_retailer retailer
    click_link "Boutiques"
    click_link retailer.name
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

    expect(page).to have_content('Your drop-in was scheduled!')
  end

  def then_my_scheduled_drop_ins_should_be_updated_with retailer, date, place
    expect(page).to have_link(retailer.name)
    expect(page).to have_content(date)
    expect(page).to have_content(place)
  end

  def then_my_scheduled_should_show_item_on_hold item
    expect(page).to have_content(item.name)
  end

  def when_i_continue_browsing
    visit '/'

    expect(page).to have_content('My Style Feed')
  end

  def then_i_should_see_i_have_an_existing_drop_in_scheduled appointment
    expect(page).to have_content('We see you have a drop-in')
    expect(page).to have_content(appointment.colloquial_time)
  end

  private

    def parse_date_and_EST datetime
      datetime_string = datetime.to_s
      zone = "Eastern Time (US & Canada)"
      est_datetime_string = ActiveSupport::TimeZone[zone]
                                          .parse(datetime_string).to_s

      est_datetime_string.split(' ').first(2)
    end
end
