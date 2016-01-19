require 'rails_helper'

feature 'Shopper is warned' do
  let(:shopper){ FactoryGirl.create(:shopper_user, first_name: 'Cynthia') }
  let(:pricey_store){ FactoryGirl.create(:retailer, name: 'La Boutique', price_index: 3) }
  let!(:store_owner1){ FactoryGirl.create(:retailer_user, retailer: pricey_store) }
  let(:plus_size_store){ FactoryGirl.create(:retailer, name: 'Curvy Boutique', size_range: "12 (L) - 20 (XXL)") }
  let!(:store_owner2){ FactoryGirl.create(:retailer_user, retailer: plus_size_store) }

  scenario 'if store is out of budget' do
    given_i_am_not_logged_in
    when_i_navigate_to_store_page pricey_store
    then_i_should_not_see_price_warning
    given_i_am_a_logged_in_user shopper
    given_my_budget_is_on_the_low_end
    when_i_navigate_to_store_page pricey_store
    then_i_should_see_price_warning
    when_i_update_my_budget_to_high_end
    when_i_navigate_to_store_page pricey_store
    then_i_should_not_see_price_warning
  end

  scenario 'if store is out of size range' do
    seed_style_profile_options

    given_i_am_not_logged_in
    when_i_navigate_to_store_page plus_size_store
    then_i_should_not_see_size_warning
    given_i_am_a_logged_in_user shopper
    given_my_size_is_small
    when_i_navigate_to_store_page plus_size_store
    then_i_should_see_size_warning
    when_i_update_my_size_to_large
    when_i_navigate_to_store_page plus_size_store
    then_i_should_not_see_size_warning
  end

  def given_i_am_not_logged_in
    visit '/'
    expect(page).to have_text('Log in')
  end

  def when_i_navigate_to_store_page store
    click_link 'Boutiques'
    click_link store.name
    expect(page).to have_text(store.quote)
  end

  def then_i_should_see_price_warning
    expect(page).to have_text("Just a head's up Cynthia!")
    expect(page).to have_text("This store is out of your typical price range")
  end

  def then_i_should_not_see_price_warning
    expect(page).to_not have_text("This store is out of your typical price range")
  end

  def then_i_should_see_size_warning
    expect(page).to have_text("Just a head's up Cynthia!")
    expect(page).to have_text("This store is out of your typical size range")
  end

  def then_i_should_not_see_size_warning
    expect(page).to_not have_text("This store is out of your typical size range")
  end

  def given_my_budget_is_on_the_low_end
    click_link 'Style Profile'
    select 'max $50', from: 'A shirt, blouse, or sweater'
    select 'max $50', from: 'A pair of pants, jeans, or a skirt'
    select 'max $50', from: 'An everyday, work, or transitional dress'
    click_button 'Save'
  end

  def when_i_update_my_budget_to_high_end
    click_link 'Style Profile'
    select 'max $100', from: 'A shirt, blouse, or sweater'
    select '$200 +', from: 'A pair of pants, jeans, or a skirt'
    select '$200 +', from: 'An everyday, work, or transitional dress'
    click_button 'Save'
  end

  def given_my_size_is_small
    click_link 'Style Profile'
    within(:css, '.top_sizes') do
      check '00 (XXS)'
    end

    within(:css, '.bottom_sizes') do
      check '00 (XXS)'
    end

    within(:css, '.dress_sizes') do
      check '00 (XXS)'
    end
    click_button 'Save'
  end

  def when_i_update_my_size_to_large
    click_link 'Style Profile'

    within(:css, '.dress_sizes') do
      check '14 (L)'
    end
    click_button 'Save'
  end
end