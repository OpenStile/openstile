require 'rails_helper'

feature 'Style Feed' do
  let(:retailer){ FactoryGirl.create(:retailer, name: 'Store A') }
  let(:retired_retailer){ FactoryGirl.create(:retailer, 
                                             status: 0,
                                             name: 'Store B') }
  let(:retired_top){ FactoryGirl.create(:top, retailer: retired_retailer,
                                      name: 'Retailer not on site top',
                                      price: 15.00) }
  let(:top){ FactoryGirl.create(:top, retailer: retailer,
                                      price: 15.00) }
  let(:staged_top){ FactoryGirl.create(:top, retailer: retailer,
                                        name: 'Not quite ready top',
                                        status: 0,
                                        price: 25.00) }
  let(:bottom){ FactoryGirl.create(:bottom, retailer: retailer,
                                      price: 100.00) }
  let(:dress){ FactoryGirl.create(:dress, retailer: retailer,
                                      price: 1000.00) }
  let(:outfit){ FactoryGirl.create(:outfit, retailer: retailer,
                                      average_price: 70.00) }
  let(:shopper){ FactoryGirl.create(:shopper) }
  let(:other_shopper){ FactoryGirl.create(:shopper) }
  let(:third_shopper){ FactoryGirl.create(:shopper) }

  scenario 'when viewing all items', js: true do
    shopper.style_profile.budget.update(top_min_price: 0, top_max_price: 100.00,
                                 bottom_min_price: 0, bottom_max_price: 100.00,
                                 dress_min_price: 0, dress_max_price: 100.00)

    dress.interested_shoppers << other_shopper
    dress.interested_shoppers << third_shopper
    bottom.interested_shoppers << other_shopper
    retired_top.interested_shoppers << other_shopper

    given_i_am_a_logged_in_shopper shopper
    then_my_style_feed_should_contain top, :all
    then_my_style_feed_should_contain bottom, :all
    then_my_style_feed_should_contain dress, :all
    then_my_style_feed_should_contain outfit, :all
    then_the_recommendation_ordering_should_be dress, bottom, false
    then_the_recommendation_ordering_should_be bottom, top, false
    then_my_style_feed_should_not_contain staged_top, :all
    then_my_style_feed_should_not_contain retired_top, :all
    then_my_style_feed_should_not_contain retailer, :all
  end
end
