require 'rails_helper'

feature 'User log in and out' do
  let(:admin){ FactoryGirl.create(:admin_user) }
  let(:retailer){ FactoryGirl.create(:retailer_user) }
  let(:shopper){ FactoryGirl.create(:shopper_user) }

  scenario 'with invalid credentials' do
    given_i_am_not_logged_in
    when_i_enter_invalid_credentials
    then_i_am_not_logged_in
  end

  scenario 'as admin' do
    given_i_am_not_logged_in
    when_i_enter_valid_credentials admin.email, admin.password
    then_i_am_logged_in
    then_i_am_directed_to_admin_home_page
    when_i_click_log_out
    then_i_am_not_logged_in
  end

  scenario 'as retailer' do
    given_i_am_not_logged_in
    when_i_enter_valid_credentials retailer.email, retailer.password
    then_i_am_logged_in
    then_i_am_directed_to_retailer_home_page
    when_i_click_log_out
    then_i_am_not_logged_in
  end

  scenario 'as shopper' do
    given_i_am_not_logged_in
    when_i_enter_valid_credentials shopper.email, shopper.password
    then_i_am_logged_in
    then_i_am_directed_to_shopper_home_page
    when_i_click_log_out
    then_i_am_not_logged_in
  end

  def given_i_am_not_logged_in
    visit '/'
    expect(page).to have_link('Log in')
    expect(page).to_not have_link('Log out')
  end

  def when_i_enter_invalid_credentials
    click_link 'Log in'
    click_button 'Log in'
    expect(page).to have_content('Invalid email or password')
  end

  def when_i_click_log_out
    click_link 'Log out'
  end

  def then_i_am_not_logged_in
    expect(page).to have_link('Log in')
    expect(page).to_not have_link('Log out')
  end

  def when_i_enter_valid_credentials email, password
    click_link 'Log in'
    fill_in 'Email', with: email
    fill_in 'Password', with: password

    click_button 'Log in'
  end

  def then_i_am_logged_in
    expect(page).to have_link('Log out')
    expect(page).to_not have_link('Log in')
  end

  def then_i_am_directed_to_admin_home_page
    expect(page).to have_content('Admin Home')
  end

  def then_i_am_directed_to_retailer_home_page
    expect(page).to have_content('manage your availability')
  end

  def then_i_am_directed_to_shopper_home_page
    expect(page).to have_content('SHOP LIKE A VIP')
  end
end