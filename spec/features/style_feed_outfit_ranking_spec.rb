require 'rails_helper'

feature 'Style Feed item ranking' do
  let(:retailer){ FactoryGirl.create(:retailer) }  
  let(:outfit1){ FactoryGirl.create(:outfit, name: 'Beautiful blouse and jeans', 
                                             retailer: retailer) }
  let(:outfit2){ FactoryGirl.create(:outfit, name: 'Comfy sweater and skirt',
                                             retailer: retailer) }
  let(:shopper){ FactoryGirl.create(:shopper) }  

  scenario 'based on body shape' do
    baseline_calibration_for_shopper_and_outfits

    original_body_shape = FactoryGirl.create(:body_shape, name: "Hourglass")
    new_body_shape = FactoryGirl.create(:body_shape, name: "Straight")

    outfit1.update!(body_shape_id: new_body_shape.id)
    outfit2.update!(body_shape_id: original_body_shape.id)

    given_i_am_a_logged_in_shopper shopper
    when_i_set_my_style_profile_body_shape_to original_body_shape
    then_my_style_feed_should_contain outfit1
    then_my_style_feed_should_contain outfit2
    then_the_recommendation_ordering_should_be outfit2, outfit1
    when_i_set_my_style_profile_body_shape_to new_body_shape
    then_my_style_feed_should_contain outfit1
    then_my_style_feed_should_contain outfit2
    then_the_recommendation_ordering_should_be outfit1, outfit2
    then_the_recommendation_should_be_for "your Body Type"
  end

  scenario 'based on body height and build' do
    baseline_calibration_for_shopper_and_outfits

    original_height = "5 feet"
    new_height = "6 feet"
    original_body_build = "Average"
    new_body_build = "Full-figured"

    outfit1.update!(for_full_figured: true)
    outfit2.update!(for_petite: true)

    given_i_am_a_logged_in_shopper shopper
    when_i_set_my_style_profile_height_to original_height
    when_i_set_my_style_profile_body_build_to original_body_build
    then_my_style_feed_should_contain outfit1
    then_my_style_feed_should_contain outfit2
    then_the_recommendation_ordering_should_be outfit2, outfit1
    when_i_set_my_style_profile_height_to new_height
    when_i_set_my_style_profile_body_build_to new_body_build
    then_my_style_feed_should_contain outfit1
    then_my_style_feed_should_contain outfit2
    then_the_recommendation_ordering_should_be outfit1, outfit2
    then_the_recommendation_should_be_for "your Body Type"
  end

  scenario 'based on favorite looks' do
    baseline_calibration_for_shopper_and_outfits

    original_look = FactoryGirl.create(:look, name: "Bohemian Chic")
    new_look = FactoryGirl.create(:look, name: "Glamorous")
    
    outfit1.update!(look_id: new_look.id)
    outfit2.update!(look_id: original_look.id)

    given_i_am_a_logged_in_shopper shopper
    when_i_set_my_style_profile_feelings_for_a_look_as original_look, :love
    when_i_set_my_style_profile_feelings_for_a_look_as new_look, :impartial
    then_my_style_feed_should_contain outfit1
    then_my_style_feed_should_contain outfit2
    then_the_recommendation_ordering_should_be outfit2, outfit1
    when_i_set_my_style_profile_feelings_for_a_look_as original_look, :impartial
    when_i_set_my_style_profile_feelings_for_a_look_as new_look, :love
    then_my_style_feed_should_contain outfit1
    then_my_style_feed_should_contain outfit2
    then_the_recommendation_ordering_should_be outfit1, outfit2
    then_the_recommendation_should_be_for "your Favorite Looks"
  end

  scenario 'based on top fit' do
    baseline_calibration_for_shopper_and_outfits

    original_fit = FactoryGirl.create(:top_fit, name: 'Loose')
    new_fit = FactoryGirl.create(:top_fit, name: 'Tight/Form-Fitting')

    outfit1.update!(top_fit_id: new_fit.id)
    outfit2.update!(top_fit_id: original_fit.id)

    given_i_am_a_logged_in_shopper shopper
    when_i_set_my_style_profile_preferred_fit_as original_fit.name, :top
    then_my_style_feed_should_contain outfit1
    then_my_style_feed_should_contain outfit2
    then_the_recommendation_ordering_should_be outfit2, outfit1
    when_i_set_my_style_profile_preferred_fit_as new_fit.name, :top
    then_my_style_feed_should_contain outfit1
    then_my_style_feed_should_contain outfit2
    then_the_recommendation_ordering_should_be outfit1, outfit2
    then_the_recommendation_should_be_for "your Preferred Fit"
  end

  scenario 'based on bottom fit' do
    baseline_calibration_for_shopper_and_outfits

    original_fit = FactoryGirl.create(:bottom_fit, name: 'Loose/Flowy')
    new_fit = FactoryGirl.create(:bottom_fit, name: 'Tight/Skinny')

    outfit1.update!(bottom_fit_id: new_fit.id)
    outfit2.update!(bottom_fit_id: original_fit.id)

    given_i_am_a_logged_in_shopper shopper
    when_i_set_my_style_profile_preferred_fit_as original_fit.name, :bottom
    then_my_style_feed_should_contain outfit1
    then_my_style_feed_should_contain outfit2
    then_the_recommendation_ordering_should_be outfit2, outfit1
    when_i_set_my_style_profile_preferred_fit_as new_fit.name, :bottom
    then_my_style_feed_should_contain outfit1
    then_my_style_feed_should_contain outfit2
    then_the_recommendation_ordering_should_be outfit1, outfit2
    then_the_recommendation_should_be_for "your Preferred Fit"
  end

  scenario 'based on special considerations' do
    baseline_calibration_for_shopper_and_outfits

    original_consideration = FactoryGirl.create(:special_consideration, name:'Second-wear')
    new_consideration = FactoryGirl.create(:special_consideration, name: 'Local designers')

    outfit1.special_considerations << new_consideration
    outfit2.special_considerations << original_consideration

    given_i_am_a_logged_in_shopper shopper
    when_i_set_my_style_profile_feelings_for_a_consideration_as original_consideration, :important
    when_i_set_my_style_profile_feelings_for_a_consideration_as new_consideration, :not_important
    then_my_style_feed_should_contain outfit1
    then_my_style_feed_should_contain outfit2
    then_the_recommendation_ordering_should_be outfit2, outfit1
    then_the_recommendation_should_be_for "Second-wear"
    when_i_set_my_style_profile_feelings_for_a_consideration_as original_consideration, :not_important
    when_i_set_my_style_profile_feelings_for_a_consideration_as new_consideration, :important
    then_my_style_feed_should_contain outfit1
    then_my_style_feed_should_contain outfit2
    then_the_recommendation_ordering_should_be outfit1, outfit2
    then_the_recommendation_should_be_for "Local designers"
  end

  scenario 'based on parts to show off' do
    baseline_calibration_for_shopper_and_outfits

    original_part = FactoryGirl.create(:part, name: "Legs")
    new_part = FactoryGirl.create(:part, name: "Midsection")

    outfit1.exposed_parts.create!(part_id: new_part.id)
    outfit2.exposed_parts.create!(part_id: original_part.id)

    given_i_am_a_logged_in_shopper shopper
    when_i_set_my_style_profile_coverage_preference_as [original_part], :flaunt
    when_i_set_my_style_profile_coverage_preference_as [new_part], :impartial
    then_my_style_feed_should_contain outfit1
    then_my_style_feed_should_contain outfit2
    then_the_recommendation_ordering_should_be outfit2, outfit1
    when_i_set_my_style_profile_coverage_preference_as [original_part], :impartial
    when_i_set_my_style_profile_coverage_preference_as [new_part], :flaunt
    then_my_style_feed_should_contain outfit1
    then_my_style_feed_should_contain outfit2
    then_the_recommendation_ordering_should_be outfit1, outfit2
    then_the_recommendation_should_be_for "your Preferred Fit"
  end

  scenario 'based on favortie prints' do
    baseline_calibration_for_shopper_and_outfits

    original_print = FactoryGirl.create(:print, name: "Animal Print")
    new_print = FactoryGirl.create(:print, name: "Bold Patterns")

    outfit1.prints << new_print
    outfit2.prints << original_print

    given_i_am_a_logged_in_shopper shopper
    when_i_set_my_style_profile_feelings_for_a_print_as original_print, :love
    when_i_set_my_style_profile_feelings_for_a_print_as new_print, :impartial
    then_my_style_feed_should_contain outfit1
    then_my_style_feed_should_contain outfit2
    then_the_recommendation_ordering_should_be outfit2, outfit1
    when_i_set_my_style_profile_feelings_for_a_print_as original_print, :impartial
    when_i_set_my_style_profile_feelings_for_a_print_as new_print, :love
    then_my_style_feed_should_contain outfit1
    then_my_style_feed_should_contain outfit2
    then_the_recommendation_ordering_should_be outfit1, outfit2
    then_the_recommendation_should_be_for "your Preferred Prints and Patterns"
  end

  private
    def baseline_calibration_for_shopper_and_outfits
      shared_top_size = FactoryGirl.create(:top_size)
      shared_bottom_size = FactoryGirl.create(:bottom_size)

      shopper.style_profile.top_sizes << shared_top_size
      shopper.style_profile.bottom_sizes << shared_bottom_size
      outfit1.top_sizes << shared_top_size
      outfit2.bottom_sizes << shared_bottom_size

      shopper.style_profile.budget.update!(top_min_price: 50.00, top_max_price: 100.00,
                                     bottom_min_price: 50.00, bottom_max_price: 100.00,
                                     dress_min_price: 50.00, dress_max_price: 100.00)

      outfit1.update!(average_price: 75.00)
      outfit2.update!(average_price: 95.00)
    end
end
