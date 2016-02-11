require 'rails_helper'

feature 'Shopper schedule drop in' do
  let(:shopper){ FactoryGirl.create(:shopper_user) }
  let(:retailer){ FactoryGirl.create(:retailer) }
  let!(:admin){ FactoryGirl.create(:admin_user) }

  let(:pop_up_location){ FactoryGirl.create(:location,
                                  address: "1309 5th St. NE, Washington, DC 20002",
                                  neighborhood: "NoMa",
                                  short_title: "Crafty Bastards at Union Market") }
  let!(:drop_in_availability) {
    FactoryGirl.create(:standard_availability_for_tomorrow,
                       retailer: retailer,
                       location: pop_up_location)
  }
  let!(:retail_user){ FactoryGirl.create(:retailer_user, retailer: retailer) }

  scenario 'for a given date and time', perform_enqueued: true do
    date, time = parse_date_and_EST(tomorrow_afternoon)
    place = "Crafty Bastards at Union Market (1309 5th St. NE, Washington, DC 20002)"

    given_i_am_a_logged_in_user shopper
    when_i_click_on_a_retailer retailer
    when_i_attempt_to_schedule_with_invalid_options retailer
    then_i_should_not_be_taken_to_my_scheduled_drop_ins
    when_i_attempt_to_schedule_with_valid_options date, time
    then_my_scheduled_drop_ins_should_be_updated_with retailer, date: "Tomorrow", place: place
    then_all_parties_should_receive_an_email [retail_user.email, shopper.email, admin.email]
  end

  scenario 'for a drop-by in 30 min', js: true, perform_enqueued: true do
    given_i_am_a_logged_in_user shopper
    when_i_click_on_a_retailer retailer
    then_i_should_not_see_a_book_in_30_option
    given_retailer_has_an_open_availability_in_30 retailer
    when_i_click_on_a_retailer retailer
    when_i_book_in_30
    then_my_scheduled_drop_ins_should_be_updated_with retailer
    then_all_parties_should_receive_an_email [retail_user.email, shopper.email, admin.email]
  end

  scenario 'upon logging in', perform_enqueued: true do
    date, time = parse_date_and_EST(tomorrow_afternoon)

    given_i_am_not_logged_in
    when_i_click_on_a_retailer retailer
    when_i_submit_values_and_log_in date, time, "Looking for a holiday dress"
    when_i_am_returned_to_my_selections_and_book time
    then_my_scheduled_drop_ins_should_be_updated_with retailer, date: "Tomorrow", comments: "Looking for a holiday dress"
    then_all_parties_should_receive_an_email [retail_user.email, shopper.email, admin.email]
  end

  scenario 'upon signing up' do
    date, time = parse_date_and_EST(tomorrow_afternoon)

    given_i_am_not_logged_in
    when_i_click_on_a_retailer retailer
    when_i_submit_values_and_sign_up date, time, "Looking for a holiday dress"
    when_i_complete_my_style_profile
    when_i_am_returned_to_my_selections_and_book time
    then_my_scheduled_drop_ins_should_be_updated_with retailer, date: "Tomorrow", comments: "Looking for a holiday dress"
  end

  scenario 'sign in from the third party scheduler widget', perform_enqueued: true do
    date, time = parse_date_and_EST(tomorrow_afternoon)

    given_i_am_viewing_the_scheduler_widget_for retailer
    when_i_click_on_the_widget
    when_i_submit_values_and_log_in date, time, "Looking for a holiday dress"
    when_i_am_returned_to_my_selections_and_book time
    then_my_scheduled_drop_ins_should_be_updated_with retailer, date: "Tomorrow", comments: "Looking for a holiday dress"
    then_all_parties_should_receive_an_email [retail_user.email, shopper.email, admin.email]
  end

  scenario 'sign up from the third party scheduler widget' do
    date, time = parse_date_and_EST(tomorrow_afternoon)

    given_i_am_viewing_the_scheduler_widget_for retailer
    when_i_click_on_the_widget
    when_i_submit_values_and_sign_up date, time, "Looking for a holiday dress"
    when_i_complete_my_style_profile
    when_i_am_returned_to_my_selections_and_book time
    then_my_scheduled_drop_ins_should_be_updated_with retailer, date: "Tomorrow", comments: "Looking for a holiday dress"
  end

  def given_i_am_not_logged_in
    visit '/'
    expect(page).to have_link('Log in')
    expect(page).to_not have_link('Log out')
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
    expect(page).to have_content("When you book a FREE styling")

    when_i_attempt_to_schedule_with_valid_options date, time
    then_my_scheduled_drop_ins_should_be_updated_with retailer, date: "Tomorrow", place: place
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
    expect(page).to have_content("When you book a FREE styling")

    when_i_attempt_to_schedule_with_valid_options date, time
    then_my_scheduled_drop_ins_should_be_updated_with retailer, date: "Tomorrow", place: place
  end

  def when_i_click_on_a_retailer retailer
    click_link "Boutiques"
    click_link retailer.name
  end

  def when_i_attempt_to_schedule_with_invalid_options recommendation
    within(:css, "div.schedule") do
      click_button 'Book session'
    end

    expect(page).to have_content('error')
    expect(page).to have_content(recommendation.description)
  end

  def then_i_should_not_be_taken_to_my_scheduled_drop_ins
    expect(page).to have_content('Book FREE Styling')
  end

  def when_i_attempt_to_schedule_with_valid_options date, time
    within(:css, "div.schedule") do
      fill_in 'Date', with: date
      fill_in 'Time', with: time
      click_button 'Book session'
    end

    expect(page).to have_content('Your drop-in was scheduled!')
  end

  def when_i_submit_values_and_log_in date, time, comments
    fill_in 'Date', with: date
    fill_in 'Time', with: time
    fill_in 'Comment', with: comments

    click_button 'Sign in and Book session'

    fill_in 'Email', with: shopper.email
    fill_in 'Password', with: shopper.password
    click_button 'Log in'

    expect(page).to have_button 'Book session'
  end

  def when_i_submit_values_and_sign_up date, time, comments
    fill_in 'Date', with: date
    fill_in 'Time', with: time
    fill_in 'Comment', with: comments

    click_button 'Sign in and Book session'

    click_link "Don't have an account? Join now."
    fill_in "First name", with: "Jane"
    fill_in "Email address", with: "jane@example.com"
    fill_in "Password", with: "foobarbaz"
    fill_in "Confirm password", with: "foobarbaz"
    click_button 'Sign up'

    expect(page).to have_title 'Style Profile'
  end

  def when_i_complete_my_style_profile
    select 'max $50', from: 'A shirt, blouse, or sweater'
    click_button 'Save'
  end

  def when_i_am_returned_to_my_selections_and_book time
    fill_in 'Time', with: time #TODO fix re-enter the time since there is a bug with preserving it
    click_button 'Book session'
  end

  def when_i_book_in_30
    click_button "I'll be there in 30 minutes!"
    expect(page).to have_content('Your drop-in was scheduled!')
  end

  def then_my_scheduled_drop_ins_should_be_updated_with retailer, options={}
    expect(page).to have_link(retailer.name)
    expect(page).to have_content(options[:date]) unless options[:date].nil?
    expect(page).to have_content(options[:place]) unless options[:place].nil?
    expect(page).to have_content(options[:comments]) unless options[:comments].nil?
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

  def then_i_should_not_see_a_book_in_30_option
    expect(page).to_not have_button("I'll be there in 30 minutes!", visible: true)
  end

  def given_retailer_has_an_open_availability_in_30 retailer
    target_time = Time.zone.now.advance(minutes: 30)

    retailer.drop_in_availabilities.create!(template_date: target_time.to_date,
                                           start_time: "00:00:00",
                                           end_time: "23:59:59",
                                           bandwidth: 1,
                                           frequency: DropInAvailability::ONE_TIME_FREQUENCY,
                                           location: retailer.location)
  end

  def then_all_parties_should_receive_an_email emails
    latest_addresees = ActionMailer::Base.deliveries[-(emails.size)..-1]
                               .map(&:to).flatten
    latest_subjects = ActionMailer::Base.deliveries[-(emails.size)..-1]
                          .map(&:subject)

    emails.each do |email|
      expect(latest_addresees).to include(email)
    end

    latest_subjects.each do |subject|
      expect(subject).to match(/(booked an OpenStile style session|scheduled a styling)/)
    end
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
