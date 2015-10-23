require 'rails_helper'

feature 'Learn about OpenStile' do
  scenario 'the user experience' do
    given_its_my_first_time_on_OpenStile
    when_i_navigate_to_the_experience_page
    then_i_should_read_about_how_OpenStile_works
    then_i_should_be_able_to_signup_for_OpenStile
  end

  def given_its_my_first_time_on_OpenStile
    visit '/'
  end

  def when_i_navigate_to_the_experience_page
    click_link 'Experience'
  end

  def then_i_should_read_about_how_OpenStile_works
    expect(page).to have_content('Shop like the V.I.P you are!')
  end

  def then_i_should_be_able_to_signup_for_OpenStile
    click_link 'Start using OpenStile today!'
    expect(page).to have_content("Create an account")
  end
end
