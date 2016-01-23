require 'rails_helper'

feature 'Admin user views shoppers' do
  let!(:admin){ FactoryGirl.create(:admin_user) }
  let(:retailer){ FactoryGirl.create(:retailer, name: 'ABC Boutique') }
  let!(:availability){ FactoryGirl.create(:standard_availability_for_tomorrow, retailer: retailer)}
  let!(:store_owner){ FactoryGirl.create(:retailer_user, retailer: retailer) }
  let(:number_of_shoppers){ 10 }

  scenario 'and sees all OpenStile details' do
    older_account_time = Time.zone.now - 3.days
    newer_account_time = Time.zone.now - 1.day
    shoppers = []
    number_of_shoppers.times{shoppers << Faker::Name.first_name}
    older_account_name, newer_account_name = shoppers.sample(2)

    given_a_bunch_of_shoppers_create_accounts shoppers
    given_a_shopper_created_an_account_on older_account_name, older_account_time
    given_a_shopper_created_an_account_on newer_account_name, newer_account_time
    given_a_shopper_has_booked_a_styling
    given_a_shopper_is_unconfirmed
    given_i_am_a_logged_in_user admin
    when_i_navigate_to_the_shoppers_page
    then_i_should_only_see_shoppers
    then_i_should_see_an_entry_for_each_shopper shoppers
    then_i_should_see_style_info_for_each_shopper
    then_newer_shoppers_should_be_listed_before_older_shoppers newer_account_time, older_account_time
    then_i_should_see_styling_count_for_shoppers
    then_i_should_see_unconfirmed_shoppers
  end

  def given_a_bunch_of_shoppers_create_accounts shopper_names
    shopper_names.each_with_index do |name, idx|
      visit '/'

      click_link 'Log in'
      click_link 'Join now'
      fill_in 'First name', with: name
      fill_in 'Email', with: "shopper_#{idx}@email.com"
      fill_in 'Password', with: 'foobar'
      fill_in 'Confirm password', with: 'foobar'
      click_button 'Sign up'

      select 'max $200', from: 'An everyday, work, or transitional dress'
      click_button 'Save'
      click_link 'Log out'
      User.last.update_attribute(:confirmed_at, Time.zone.now)
    end
  end

  def given_a_shopper_created_an_account_on name, datetime
    User.find_by_first_name(name).update_attribute(:created_at, datetime)
  end

  def given_a_shopper_has_booked_a_styling
    visit '/'

    click_link 'Log in'
    fill_in 'Email', with: "shopper_#{rand(0..number_of_shoppers - 1)}@email.com"
    fill_in 'Password', with: 'foobar'
    click_button 'Log in'

    click_link 'Boutiques'
    click_link 'ABC Boutique'
    fill_in 'Date', with: 1.day.from_now.strftime('%Y-%m-%d')
    fill_in 'Time', with: '10:00:00'
    click_button 'Book session'
  end

  def given_a_shopper_is_unconfirmed
    User.find_by_email("shopper_#{rand(0..number_of_shoppers - 1)}@email.com").update_attribute(:confirmed_at, nil)
  end

  def when_i_navigate_to_the_shoppers_page
    click_link 'View all shoppers'
  end

  def then_i_should_only_see_shoppers
    expect(page).to_not have_text(store_owner.email)
    expect(page).to_not have_text(admin.email)
  end

  def then_i_should_see_an_entry_for_each_shopper shoppers
    shoppers.each_with_index do |name, idx|
      expect(page).to have_text(name)
      expect(page).to have_text("shopper_#{idx}@email.com")
    end
  end

  def then_i_should_see_style_info_for_each_shopper
    expect(page).to have_text('Dresses Budget: max $200', count: number_of_shoppers)
  end

  def then_newer_shoppers_should_be_listed_before_older_shoppers newer, older
    expect(page).to have_text("Account created: #{newer.strftime('%D')}")
    expect(page).to have_text("Account created: #{older.strftime('%D')}")

    expect(page.body.index(newer.strftime('%D'))).to be < page.body.index(older.strftime('%D'))
  end

  def then_i_should_see_styling_count_for_shoppers
    expect(page).to have_text('Styling count: 1', count: 1)
  end

  def then_i_should_see_unconfirmed_shoppers
    expect(page).to have_text('[Unconfirmed]', count: 1)
  end
end