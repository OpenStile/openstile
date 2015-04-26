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

  let(:top_size){ FactoryGirl.create(:top_size) }
  let(:bottom_size){ FactoryGirl.create(:bottom_size) }
  let(:dress_size){ FactoryGirl.create(:dress_size) }
  let(:hourglass){ FactoryGirl.create(:body_shape, name: "Hourglass") }
  let(:boho_chic){ FactoryGirl.create(:look, name: "Bohemian Chic") }
  let(:oversized){ FactoryGirl.create(:top_fit, name: "Oversized") }
  let(:fitted){ FactoryGirl.create(:bottom_fit, name: "Fitted") }
  let(:local_designers){ FactoryGirl.create(:special_consideration, name: "Local designers") }
  let(:cleavage){ FactoryGirl.create(:part, name: "Cleavage") }
  let(:animal_print){ FactoryGirl.create(:print, name: "Animal Print") }

  scenario 'when viewing featured items', js: true do
    top.update(body_shape: hourglass)
    top.update(for_full_figured: true)
    top.update(for_tall: true)
    top.update(look: boho_chic)
    top.update(top_fit: oversized)
    top.top_sizes << top_size
    top.update!(price: 105.00)
    bottom.bottom_sizes << bottom_size
    bottom.update!(price: 105.00)
    outfit.update(bottom_fit: fitted)
    outfit.special_considerations << local_designers
    outfit.exposed_parts.create!(part: cleavage)
    outfit.top_sizes << top_size
    outfit.update!(average_price: 105.00)
    dress.update(print: animal_print)
    dress.dress_sizes << dress_size
    dress.update!(price: 105.00)

    given_i_am_a_logged_in_shopper shopper
    when_i_set_my_style_profile_sizes_to({ top_size: top_size, 
                                            bottom_size: bottom_size,
                                            dress_size: dress_size })
    when_i_set_my_style_profile_budget_to({ dress: 'max $150',
                                            bottom: 'max $150',
                                            top: 'max $150' })
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
end
