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

    original_height = "5 feet"
    new_height = "6 feet"
    original_body_build = "Average"
    new_body_build = "Full-figured"

    retailer_one.update!(for_full_figured: true)
    retailer_two.update!(for_petite: true)

    given_i_am_a_logged_in_shopper shopper
    when_i_set_my_style_profile_height_to original_height
    when_i_set_my_style_profile_body_build_to original_body_build
    then_my_style_feed_should_contain retailer_one
    then_my_style_feed_should_contain retailer_two
    then_the_recommendation_ordering_should_be retailer_two, retailer_one
    when_i_set_my_style_profile_height_to new_height
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

  scenario 'based on top fit' do
    baseline_calibration_for_shopper_and_retailers

    original_fit = 'Loose'
    new_fit = 'Tight/Form-Fitting'

    retailer_one.update!(top_fit: new_fit)
    retailer_two.update!(top_fit: original_fit)

    given_i_am_a_logged_in_shopper shopper
    when_i_set_my_style_profile_preferred_fit_as original_fit, :top
    then_my_style_feed_should_contain retailer_one
    then_my_style_feed_should_contain retailer_two
    then_the_recommendation_ordering_should_be retailer_two, retailer_one
    when_i_set_my_style_profile_preferred_fit_as new_fit, :top
    then_my_style_feed_should_contain retailer_one
    then_my_style_feed_should_contain retailer_two
    then_the_recommendation_ordering_should_be retailer_one, retailer_two
    then_the_recommendation_should_be_for "your Preferred Fit"
  end

  scenario 'based on bottom fit' do
    baseline_calibration_for_shopper_and_retailers

    original_fit = 'Loose/Flowy'
    new_fit = 'Tight/Skinny'

    retailer_one.update!(bottom_fit: new_fit)
    retailer_two.update!(bottom_fit: original_fit)

    given_i_am_a_logged_in_shopper shopper
    when_i_set_my_style_profile_preferred_fit_as original_fit, :bottom
    then_my_style_feed_should_contain retailer_one
    then_my_style_feed_should_contain retailer_two
    then_the_recommendation_ordering_should_be retailer_two, retailer_one
    when_i_set_my_style_profile_preferred_fit_as new_fit, :bottom
    then_my_style_feed_should_contain retailer_one
    then_my_style_feed_should_contain retailer_two
    then_the_recommendation_ordering_should_be retailer_one, retailer_two
    then_the_recommendation_should_be_for "your Preferred Fit"
  end

  scenario 'based on special considerations' do
    baseline_calibration_for_shopper_and_retailers

    original_consideration = FactoryGirl.create(:special_consideration, name:'Second-wear')
    new_consideration = FactoryGirl.create(:special_consideration, name: 'Local designers')

    retailer_one.special_considerations << new_consideration
    retailer_two.special_considerations << original_consideration

    given_i_am_a_logged_in_shopper shopper
    when_i_set_my_style_profile_feelings_for_a_consideration_as original_consideration, :important
    when_i_set_my_style_profile_feelings_for_a_consideration_as new_consideration, :not_important
    then_my_style_feed_should_contain retailer_one
    then_my_style_feed_should_contain retailer_two
    then_the_recommendation_ordering_should_be retailer_two, retailer_one
    then_the_recommendation_should_be_for "Second-wear"
    when_i_set_my_style_profile_feelings_for_a_consideration_as original_consideration, :not_important
    when_i_set_my_style_profile_feelings_for_a_consideration_as new_consideration, :important
    then_my_style_feed_should_contain retailer_one
    then_my_style_feed_should_contain retailer_two
    then_the_recommendation_ordering_should_be retailer_one, retailer_two
    then_the_recommendation_should_be_for "Local designers"
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
