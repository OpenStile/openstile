require 'rails_helper'

feature 'Style Feed retailer matching' do
  scenario 'based on size' do
    retailer = FactoryGirl.create(:retailer)

    original_sizes = {top_size: "Small", bottom_size: "Small", dress_size: "Small"}
    new_sizes = {top_size: "Large", bottom_size: "Large", dress_size: "Large"}

    FactoryGirl.create(:top_size, name: "Small")
    FactoryGirl.create(:bottom_size, name: "Small")
    FactoryGirl.create(:dress_size, name: "Small")

    retailer.top_sizes << FactoryGirl.create(:top_size, name: "Large")
    retailer.bottom_sizes << FactoryGirl.create(:bottom_size, name: "Large")
    retailer.dress_sizes << FactoryGirl.create(:dress_size, name: "Large")

    given_i_am_a_logged_in_shopper
    when_i_set_my_style_profile_sizes_to original_sizes
    then_my_style_feed_should_not_contain retailer
    when_i_set_my_style_profile_sizes_to new_sizes
    then_my_style_feed_should_contain retailer
  end

  def given_i_am_a_logged_in_shopper
    @shopper = FactoryGirl.create(:shopper)

    visit '/'
    click_link 'Log in'
    fill_in 'Email', with: @shopper.email
    fill_in 'Password', with: @shopper.password
    click_button 'Log in'
  end

  def when_i_set_my_style_profile_sizes_to size_hash
    click_link 'Style Profile'

    within(:css, "div#top_sizes") do
      check(size_hash[:top_size])
    end
    within(:css, "div#bottom_sizes") do
      check(size_hash[:bottom_size])
    end
    within(:css, "div#dress_sizes") do
      check(size_hash[:dress_size])
    end
    click_button 'Save and continue to Style Feed'

    expect(page).to have_content('My Style Feed')
  end

  def then_my_style_feed_should_contain recommendation
    visit '/'
    expect(page).to have_content(recommendation.name)
  end

  def then_my_style_feed_should_not_contain recommendation
    visit '/'
    expect(page).to_not have_content(recommendation.name)
  end
end
