require 'rails_helper'

feature 'Shopper shares style preferences with retailer' do
  let(:shopper){ FactoryGirl.create(:shopper, first_name: 'Jane') }
  let(:retailer){ FactoryGirl.create(:retailer, name: 'ABC Boutique') }
  let!(:availability){ FactoryGirl.create(:standard_availability_for_tomorrow, retailer: retailer)}
  let!(:store_owner){ FactoryGirl.create(:retail_user, retailer: retailer,
                                        email: 'me@myboutique.com', password: 'password',
                                        password_confirmation: 'password') }

  scenario 'and specifies her size preferences' do
    seed_style_profile_options

    given_i_am_a_logged_in_shopper shopper
    when_i_navigate_to_my_style_profile
    when_i_set_my_top_sizes_as ['2 (XS)', '4 (S)']
    when_i_set_my_bottom_sizes_as ['8 (M)']
    when_i_set_my_dress_sizes_as ['6 (S)', '8 (M)']
    when_i_save_my_style_profile
    when_i_schedule_a_dropin_with_retailer
    then_the_store_owner_should_know "Tops\nSizes: 2 (XS), 4 (S)\nBottoms\n Sizes: 8 (M)\nDresses\nSizes: 6 (S), 8 (M)"
  end

  scenario 'and specifies her build' do
    seed_style_profile_options

    given_i_am_a_logged_in_shopper shopper
    when_i_navigate_to_my_style_profile
    when_i_set_my_build_as ['Petite', 'Curvy']
    when_i_save_my_style_profile
    when_i_schedule_a_dropin_with_retailer
    then_the_store_owner_should_know "Build considerations: Petite, Curvy\n"
  end

  scenario 'and specifies her budget' do
    seed_style_profile_options

    given_i_am_a_logged_in_shopper shopper
    when_i_navigate_to_my_style_profile
    when_i_set_my_top_budget_as 'max $50'
    when_i_set_my_bottom_budget_as 'max $150'
    when_i_set_my_dress_budget_as '$200 +'
    when_i_save_my_style_profile
    when_i_schedule_a_dropin_with_retailer
    then_the_store_owner_should_know "Tops\nBudget: max $50\nBottoms\nBudget: max $150\nDresses\nBudget: $200 +"
  end

  scenario 'and specifies her favorite looks' do
    seed_style_profile_options

    given_i_am_a_logged_in_shopper shopper
    when_i_navigate_to_my_style_profile
    when_i_select_as_a_loved_look ['Hipster1']
    when_i_save_my_style_profile
    when_i_schedule_a_dropin_with_retailer
    then_the_store_owner_should_know 'Loved looks:'
    expect(page).to have_xpath("//img[@alt='Hipster1']")
  end

  scenario 'and specifies what is important to her' do
    seed_style_profile_options

    given_i_am_a_logged_in_shopper shopper
    when_i_navigate_to_my_style_profile
    when_i_select_as_important ['Ethically-made', 'Made in USA']
    when_i_save_my_style_profile
    when_i_schedule_a_dropin_with_retailer
    then_the_store_owner_should_know "Values: Made in USA, Ethically-made\n"
  end

  def when_i_navigate_to_my_style_profile
    click_link 'Style Profile'
  end

  def when_i_set_my_top_sizes_as sizes
    within(:css, '.top_sizes') do
      sizes.each{|size| check size}
    end
  end

  def when_i_set_my_bottom_sizes_as sizes
    within(:css, '.bottom_sizes') do
      sizes.each{|size| check size}
    end
  end

  def when_i_set_my_dress_sizes_as sizes
    within(:css, '.dress_sizes') do
      sizes.each{|size| check size}
    end
  end

  def when_i_set_my_build_as builds
    within(:css, '.build') do
      builds.each{|build| check build}
    end
  end

  def when_i_set_my_top_budget_as amount
    select amount, from: 'A shirt, blouse, or sweater'
  end

  def when_i_set_my_bottom_budget_as amount
    select amount, from: 'A pair of pants, jeans, or a skirt'
  end

  def when_i_set_my_dress_budget_as amount
    select amount, from: 'An everyday, work, or transitional dress'
  end

  def when_i_select_as_a_loved_look looks
    looks.each{|look|
      id = page.find(:xpath, "//img[@alt='#{look}']/..")['data-id']
      check id
    }
  end

  def when_i_select_as_important values
    values.each{|value| check value}
  end

  def when_i_save_my_style_profile
    click_button 'Save and continue'
    expect(page).to have_text('My Drop-Ins')
  end

  def when_i_schedule_a_dropin_with_retailer
    click_link 'Boutiques'
    click_link 'ABC Boutique'
    fill_in 'Date', with: 1.day.from_now.strftime('%Y-%m-%d')
    fill_in 'Time', with: '10:00:00'
    click_button 'Schedule'
  end

  def then_the_store_owner_should_know style_synopsis
    click_link 'Log out'
    click_link 'Log in'
    click_link 'Switch to retailer'
    fill_in 'Email', with: 'me@myboutique.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    click_link 'My appointments'
    expect(page).to have_text('Jane Tomorrow @ 10 AM')
    expect(page).to have_text(style_synopsis)
  end

  private

  def seed_style_profile_options
    ['2 (XS)', '4 (S)', '6 (S)'].each{|s| FactoryGirl.create(:top_size, name: s)}
    ['6 (S)', '8 (M)', '10 (M)'].each{|s| FactoryGirl.create(:dress_size, name: s)}
    ['6 (S)', '8 (M)', '10 (M)'].each{|s| FactoryGirl.create(:bottom_size, name: s)}

    ['Petite', 'Curvy', 'Tall'].each{|b| FactoryGirl.create(:body_build, name: b)}

    ['Hipster1', 'Girly2', 'Rocker3'].each{|l| FactoryGirl.create(:look, name: l)}

    ['Made in USA', 'Ethically-made', 'Eco-friendly'].each{|sc|
      FactoryGirl.create(:special_consideration, name: sc) }
  end
end