require 'rails_helper'

feature 'Style Feed' do
  let!(:retailer_one){ FactoryGirl.create(:retailer, name: 'Store A') }
  let!(:retailer_two){ FactoryGirl.create(:retailer, name: 'Store B') }
  let!(:retailer_three){ FactoryGirl.create(:retailer, name: 'Store C') }
  let!(:retired_retailer){ FactoryGirl.create(:retailer, 
                                             status: 0,
                                             name: 'Store D') }
  let!(:top){ FactoryGirl.create(:top, retailer: retailer_one) }
  let(:shopper){ FactoryGirl.create(:shopper) }

  let(:hourglass){ FactoryGirl.create(:body_shape, name: "Hourglass") }
  let(:boho_chic){ FactoryGirl.create(:look, name: "Bohemian Chic") }
  let(:oversized){ FactoryGirl.create(:top_fit, name: "Oversized") }
  let(:fitted){ FactoryGirl.create(:bottom_fit, name: "Fitted") }
  let(:local_designers){ FactoryGirl.create(:special_consideration, 
                                             name: "Local designers") }

  scenario 'when viewing retailers', js: true do
    baseline_calibration_for_shopper_and_retailers

    retailer_one.update(body_shape: hourglass)
    retailer_one.update(for_full_figured: true)
    retailer_one.update(for_tall: true)
    retailer_one.update(look: boho_chic)
    retailer_one.update(top_fit: oversized)
    retailer_two.update(bottom_fit: fitted)
    retailer_two.special_considerations << local_designers

    given_i_am_a_logged_in_shopper shopper
    when_i_set_my_style_profile_body_shape_to hourglass
    when_i_set_my_style_profile_height_to "6 feet"
    when_i_set_my_style_profile_body_build_to "Full-figured"
    when_i_set_my_style_profile_feelings_for_a_look_as boho_chic, :love
    when_i_set_my_style_profile_preferred_fit_as "Oversized", :top
    when_i_set_my_style_profile_preferred_fit_as "Fitted", :bottom
    when_i_set_my_style_profile_feelings_for_a_consideration_as local_designers, 
                                                                :important
    when_i_view_retailers_in_style_feed
    then_the_feed_should_contain retailer_one
    then_the_feed_should_contain retailer_two
    then_the_feed_should_contain retailer_three
    then_the_feed_should_not_contain top
    then_the_feed_should_not_contain retired_retailer
    then_the_recommendation_ordering_should_be retailer_one, retailer_two
    then_the_recommendation_ordering_should_be retailer_two, retailer_three
  end

  private
    def baseline_calibration_for_shopper_and_retailers
      shared_size = FactoryGirl.create(:top_size)
      shopper.style_profile.top_sizes << shared_size
      retailer_one.top_sizes << shared_size
      retailer_two.top_sizes << shared_size

      shopper.style_profile.budget.update!(top_min_price: 50.00, top_max_price: 100.00)
      retailer_one.create_price_range!(top_min_price: 50.00, top_max_price: 100.00)
      retailer_two.create_price_range!(top_min_price: 50.00, top_max_price: 100.00)
    end
end
