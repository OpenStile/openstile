require 'rails_helper'

feature 'Admin user' do
  let(:admin){ FactoryGirl.create(:admin) }

  scenario 'logs in' do
    given_i_am_not_logged_in
    when_i_visit_admin_log_in
    when_i_enter_invalid_credentials
    then_i_am_not_logged_in
    when_i_enter_valid_credentials
    then_i_am_logged_in
    then_i_am_directed_to_admin_home_page
  end

  scenario 'logs out' do
    given_i_am_a_logged_in_admin admin
    when_i_click_log_out
    then_i_am_not_logged_in
  end

  def given_i_am_not_logged_in
    visit '/'
    expect(page).to have_link('Log in')
    expect(page).to_not have_link('Log out')
  end

  def given_i_am_a_logged_in_admin admin_user
    visit '/admins/sign_in'
    fill_in 'Email', with: admin_user.email
    fill_in 'Password', with: admin_user.password

    click_button 'Log in'
  end
    
  def when_i_visit_admin_log_in
    visit '/admins/sign_in'
    expect(page).to have_content('Admin log in')
  end

  def when_i_enter_invalid_credentials
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

  def when_i_enter_valid_credentials
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password

    click_button 'Log in'
  end

  def then_i_am_logged_in
    expect(page).to have_link('Log out')
    expect(page).to_not have_link('Log in')
  end

  def then_i_am_directed_to_admin_home_page
    expect(page).to have_content('Admin Home')
  end

end
