require 'rails_helper'

feature 'User visits during site reconstruction' do
  before(:all) do
    ENV['OST_RELAUNCH_PREP'] = 'true'
  end

  after(:all) do
    ENV.delete('OST_RELAUNCH_PREP')
  end

  scenario 'and attempts to sign up' do
    visit '/'
    click_link 'Log in'
    click_link "Don't have an account? Join now"
    then_i_should_see_relaunch_message
  end

  scenario 'and attempts to access the boutiques page' do
    visit '/'
    click_link 'Boutiques'
    then_i_should_see_relaunch_message
  end

  scenario 'and attempts to access the about page' do
    visit '/'
    click_link 'About'
    then_i_should_see_relaunch_message
  end

  scenario 'and goes to home page' do
    visit '/'
    then_i_should_see_relaunch_message false
  end

  scenario 'and attempts to sign in as shopper' do
    visit '/'
    click_link 'Log in'
    then_i_should_see_relaunch_message false
  end

  scenario 'and attempts to sign in as retailer' do
    visit '/'
    click_link 'Log in'
    click_link 'Switch to retailer log in'
    then_i_should_see_relaunch_message false
  end

  scenario 'and attempts to sign in as admin' do
    visit new_admin_session_path
    then_i_should_see_relaunch_message false
  end

  scenario 'and attempts to access the blog page' do
    visit '/'
    first(:link, 'Blog').click
    then_i_should_see_relaunch_message false
  end

  def then_i_should_see_relaunch_message assert=true
    if assert
      expect(page).to have_content('stay tuned for our relaunch')
    else
      expect(page).to_not have_content('stay tuned for our relaunch')
    end
  end
end