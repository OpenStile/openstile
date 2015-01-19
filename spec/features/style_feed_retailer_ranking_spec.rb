require 'rails_helper'

feature 'Style Feed retailer ranking' do
  let(:retailer_one){ FactoryGirl.create(:retailer, name: "Shop A") }
  let(:retailer_two){ FactoryGirl.create(:retailer, name: "Shop B") }
  let(:shopper){ FactoryGirl.create(:shopper) }
  
  scenario 'based on body shape' do
    baseline_calibration_for_shopper_and_retailers

    original_body_shape = FactoryGirl.create(:body_shape, name: "Hourglass")
    new_body_shape = FactoryGirl.create(:body_shape, name: "Straight")

    retailer_one.update!(body_shape_id: new_body_shape.id)
    retailer_two.update!(body_shape_id: original_body_shape.id)

    given_i_am_a_logged_in_shopper shopper
    when_i_set_my_style_profile_body_shape_to original_body_shape
    then_my_style_feed_should_contain retailer_one
    then_my_style_feed_should_contain retailer_two
    then_the_recommendation_ordering_should_be retailer_two, retailer_one
    when_i_set_my_style_profile_body_shape_to new_body_shape
    then_my_style_feed_should_contain retailer_one
    then_my_style_feed_should_contain retailer_two
    then_the_recommendation_ordering_should_be retailer_one, retailer_two
    then_the_recommendation_should_be_for "your Body Type"
  end

  scenario 'based on body height and build' do
    baseline_calibration_for_shopper_and_retailers

    height = "5 feet"
    original_body_build = "Average"
    new_body_build = "Full-figured"

    retailer_one.update!(for_full_figured: true)
    retailer_two.update!(for_petite: true)

    given_i_am_a_logged_in_shopper shopper
    when_i_set_my_style_profile_height_to height
    when_i_set_my_style_profile_body_build_to original_body_build
    then_my_style_feed_should_contain retailer_one
    then_my_style_feed_should_contain retailer_two
    then_the_recommendation_ordering_should_be retailer_two, retailer_one
    when_i_set_my_style_profile_body_build_to new_body_build
    then_my_style_feed_should_contain retailer_one
    then_my_style_feed_should_contain retailer_two
    then_the_recommendation_ordering_should_be retailer_one, retailer_two
    then_the_recommendation_should_be_for "your Body Type"
  end

  scenario 'based on look' do
    baseline_calibration_for_shopper_and_retailers

    original_look = FactoryGirl.create(:look, name: "Bohemian Chic")
    new_look = FactoryGirl.create(:look, name: "Glamorous")
    
    retailer_one.update!(look_id: new_look.id)
    retailer_two.update!(look_id: original_look.id)

    given_i_am_a_logged_in_shopper shopper
    when_i_set_my_style_profile_feelings_for_a_look_as original_look, :love
    when_i_set_my_style_profile_feelings_for_a_look_as new_look, :impartial
    then_my_style_feed_should_contain retailer_one
    then_my_style_feed_should_contain retailer_two
    then_the_recommendation_ordering_should_be retailer_two, retailer_one
    when_i_set_my_style_profile_feelings_for_a_look_as original_look, :impartial
    when_i_set_my_style_profile_feelings_for_a_look_as new_look, :love
    then_my_style_feed_should_contain retailer_one
    then_my_style_feed_should_contain retailer_two
    then_the_recommendation_ordering_should_be retailer_one, retailer_two
    then_the_recommendation_should_be_for "your Favorite Looks"
  end

  def when_i_set_my_style_profile_body_shape_to body_shape
    click_link 'Style Profile'

    within(:css, "div.body-shape") do
      choose("style_profile_body_shape_id_#{body_shape.id}")
    end
 
    click_button style_profile_save 
    expect(page).to have_content('My Style Feed')
  end

  def when_i_set_my_style_profile_height_to height
    click_link 'Style Profile'

    feet = height.first if height.match(/^\d\sfeet/)

    within(:css, "div.height") do
      select feet, from: 'feet'
      select "0", from: 'inches'
    end

    click_button style_profile_save 
    expect(page).to have_content('My Style Feed')
  end

  def when_i_set_my_style_profile_body_build_to build
    click_link 'Style Profile'

    within(:css, "div.body-build") do
      select build, from: 'Build'
    end

    click_button style_profile_save 
    expect(page).to have_content('My Style Feed')
  end

  def then_the_recommendation_ordering_should_be higher_ranking, lower_ranking
    visit '/'
    expect(page.body.index(higher_ranking.name)).to be < (page.body.index(lower_ranking.name))
  end

  def then_the_recommendation_should_be_for recommendation_string
    visit '/'
    expect(page).to have_content("is recommended for #{recommendation_string}")
  end

  private
    def baseline_calibration_for_shopper_and_retailers
      shared_size = FactoryGirl.create(:top_size)
      shopper.style_profile.top_sizes << shared_size
      retailer_one.top_sizes << shared_size
      retailer_two.top_sizes << shared_size

      shopper.style_profile.budget.update!(top_min_price: 50.00, top_max_price: 100.00)
      retailer_one.price_range.update!(top_min_price: 50.00, top_max_price: 100.00)
      retailer_two.price_range.update!(top_min_price: 50.00, top_max_price: 100.00)
    end
end
