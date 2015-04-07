require 'rails_helper'

feature 'Style Feed' do
  let(:retailer){ FactoryGirl.create(:retailer, name: 'Store A') }
  let(:retired_retailer){ FactoryGirl.create(:retailer, 
                                             status: 0,
                                             name: 'Store B') }
  let!(:retired_top){ FactoryGirl.create(:top, retailer: retired_retailer,
                                          name: 'Retailer not on site top') }
  let!(:staged_top){ FactoryGirl.create(:top, retailer: retailer,
                                         name: 'Not quite ready top',
                                         status: 0) }
  let!(:top){ FactoryGirl.create(:top, retailer: retailer) }
  let!(:bottom){ FactoryGirl.create(:bottom, retailer: retailer) }
  let!(:dress){ FactoryGirl.create(:dress, retailer: retailer) }
  let!(:outfit){ FactoryGirl.create(:outfit, retailer: retailer) }
  let(:shopper){ FactoryGirl.create(:shopper) }

  let(:hourglass){ FactoryGirl.create(:body_shape, name: "Hourglass") }
  let(:boho_chic){ FactoryGirl.create(:look, name: "Bohemian Chic") }
  let(:oversized){ FactoryGirl.create(:top_fit, name: "Oversized") }
  let(:fitted){ FactoryGirl.create(:bottom_fit, name: "Fitted") }
  let(:local_designers){ FactoryGirl.create(:special_consideration, name: "Local designers") }
  let(:cleavage){ FactoryGirl.create(:part, name: "Cleavage") }
  let(:animal_print){ FactoryGirl.create(:print, name: "Animal Print") }

  scenario 'when viewing featured items', js: true do
    baseline_calibration_for_shopper_and_items

    top.update(body_shape: hourglass)
    top.update(for_full_figured: true)
    top.update(for_tall: true)
    top.update(look: boho_chic)
    top.update(top_fit: oversized)
    outfit.update(bottom_fit: fitted)
    outfit.special_considerations << local_designers
    outfit.exposed_parts.create!(part: cleavage)
    dress.update(print: animal_print)

    given_i_am_a_logged_in_shopper shopper
    when_i_set_my_style_profile_body_shape_to hourglass
    when_i_set_my_style_profile_height_to "6 feet"
    when_i_set_my_style_profile_body_build_to "Full-figured"
    when_i_set_my_style_profile_feelings_for_a_look_as boho_chic, :love
    when_i_set_my_style_profile_preferred_fit_as "Oversized", :top
    when_i_set_my_style_profile_preferred_fit_as "Fitted", :bottom
    when_i_set_my_style_profile_feelings_for_a_consideration_as local_designers, :important
    when_i_set_my_style_profile_coverage_preference_as [cleavage], :flaunt
    when_i_set_my_style_profile_feelings_for_a_print_as animal_print, :love
    when_i_view_featured_items_in_style_feed
    then_the_feed_should_contain top
    then_the_feed_should_contain bottom
    then_the_feed_should_contain dress
    then_the_feed_should_contain outfit
    then_the_feed_should_not_contain staged_top
    then_the_feed_should_not_contain retired_top
    then_the_feed_should_not_contain retailer
    then_the_recommendation_ordering_should_be top, outfit
    then_the_recommendation_ordering_should_be outfit, dress
    then_the_recommendation_ordering_should_be dress, bottom
  end

  private
    def baseline_calibration_for_shopper_and_items
      shared_top_size = FactoryGirl.create(:top_size)
      shared_bottom_size = FactoryGirl.create(:bottom_size)
      shared_dress_size = FactoryGirl.create(:dress_size)

      shopper.style_profile.top_sizes << shared_top_size
      top.top_sizes << shared_top_size
      shopper.style_profile.bottom_sizes << shared_bottom_size
      bottom.bottom_sizes << shared_bottom_size
      shopper.style_profile.dress_sizes << shared_dress_size
      dress.dress_sizes << shared_dress_size
      outfit.top_sizes << shared_top_size

      shopper.style_profile.budget.update!(top_min_price: 50.00, top_max_price: 100.00,
                                     bottom_min_price: 50.00, bottom_max_price: 100.00,
                                     dress_min_price: 50.00, dress_max_price: 100.00)

      top.update!(price: 75.00)
      bottom.update!(price: 75.00)
      dress.update!(price: 75.00)
      outfit.update!(average_price: 75.00)
    end
end
