require 'rails_helper'

feature 'Learn about OpenStile' do
  scenario 'the user experience' do
    given_its_my_first_time_on_OpenStile
    when_i_navigate_to_the_experience_page
    then_i_should_read_about_how_OpenStile_works
  end

  def given_its_my_first_time_on_OpenStile
    visit '/'
  end

  def when_i_navigate_to_the_experience_page
    #click_link 'Experience' - Temporarily remove in prelaunch
    visit '/experience'
  end

  def then_i_should_read_about_how_OpenStile_works
    expect(page).to have_content('Work with the boutique to get your perfect look')
  end
end
