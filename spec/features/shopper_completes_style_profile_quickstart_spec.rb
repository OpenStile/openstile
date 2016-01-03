require 'rails_helper'

feature 'Shopper style profile quickstart' do
  let(:shopper){ FactoryGirl.create(:shopper_user) }
  before do
    seed_style_profile_options
  end

  scenario 'from homepage' do
    given_i_visit_the_homepage
    when_i_set_my_top_sizes_as ['2 (XS)', '4 (S)']
    when_i_set_my_build_as ['Petite', 'Curvy']
    when_i_set_my_bottom_budget_as 'max $150'
    click_button "Let's get started!"
    then_i_should_be_taken_to_the_full_style_profile
    when_i_select_as_important ['Ethically-made', 'Made in USA']
    when_i_choose_to_downplay ['Midsection']
    click_button 'Save and create account'
    when_i_submit_new_account_info
    then_i_should_be_taken_to_dropins_page
    then_my_style_profile_should_reflect_my_selections
  end

  scenario 'from experience page' do
    given_i_visit_the_experience_page
    when_i_set_my_top_sizes_as ['2 (XS)', '4 (S)']
    when_i_set_my_build_as ['Petite', 'Curvy']
    when_i_set_my_bottom_budget_as 'max $150'
    click_button "Let's get started!"
    then_i_should_be_taken_to_the_full_style_profile
    when_i_select_as_important ['Ethically-made', 'Made in USA']
    when_i_choose_to_downplay ['Midsection']
    click_button 'Save and create account'
    when_i_submit_new_account_info
    then_i_should_be_taken_to_dropins_page
    then_my_style_profile_should_reflect_my_selections
  end

  scenario 'if already singed in' do
    given_i_am_a_logged_in_user shopper
    given_i_visit_the_experience_page
    then_i_should_not_see_quickstart
  end

  def given_i_visit_the_homepage
    visit '/'
  end

  def given_i_visit_the_experience_page
    visit '/'
    find(:xpath, "//a/img[@alt='Survey']/..").click
    expect(page).to have_text('SHOP LIKE A VIP')
  end

  def then_i_should_not_see_quickstart
    expect(page).to_not have_selector('form')
  end

  def when_i_set_my_top_sizes_as sizes
    within(:css, '.top_sizes') do
      sizes.each{|size| check size}
    end
  end

  def when_i_set_my_build_as builds
    within(:css, '.build') do
      builds.each{|build| check build}
    end
  end

  def when_i_set_my_bottom_budget_as amount
    select amount, from: 'A pair of pants, jeans, or a skirt'
  end

  def when_i_select_as_important values
    values.each{|value| check value}
  end

  def when_i_choose_to_downplay parts
    within(:css, '.cover') do
      parts.each{|part| check part}
    end
  end

  def then_i_should_be_taken_to_the_full_style_profile
    expect(page).to have_title('Style Profile')
  end

  def when_i_submit_new_account_info
    fill_in 'First name', with: 'Jane'
    fill_in 'Email', with: 'jane@foobar.com'
    fill_in 'Password', with: 'foobar'
    fill_in 'Confirm password', with: 'foobar'
    click_button 'Sign up'
  end

  def then_i_should_be_taken_to_dropins_page
    expect(page).to have_text('Your account has been successfully created')
    expect(page).to have_text('SHOP LIKE A VIP')
  end

  def then_my_style_profile_should_reflect_my_selections
    click_link 'Style Profile'

    within(:css, '.top_sizes') do
      expect(find_field('2 (XS)')).to be_checked
      expect(find_field('4 (S)')).to be_checked
      expect(find_field('6 (S)')).to_not be_checked
    end

    expect(find_field('Petite')).to be_checked
    expect(find_field('Curvy')).to be_checked
    expect(find_field('Tall')).to_not be_checked

    expect(find_field('Ethically-made')).to be_checked
    expect(find_field('Made in USA')).to be_checked
    expect(find_field('Eco-friendly')).to_not be_checked
  end
end