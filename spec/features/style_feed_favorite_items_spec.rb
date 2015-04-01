require 'rails_helper'

feature 'Style Feed' do
  let!(:outfit){ FactoryGirl.create(:outfit) }
  let!(:old_favorite_outfit){ FactoryGirl.create(:outfit, status: 0) }
  let(:shopper){ FactoryGirl.create(:shopper) }

  scenario 'adding and removing favorites', js: true do
    old_favorite_outfit.interested_shoppers << shopper

    given_i_am_a_logged_in_shopper shopper
    when_i_navigate_to_my_style_feed
    then_my_style_feed_should_not_contain old_favorite_outfit, :favorites, false
    then_my_style_feed_should_not_contain outfit, :favorites, false
    when_i_toggle_my_like_for_an_item_in_my_style_feed outfit, "outfits_#{outfit.id}"
    then_my_style_feed_should_contain outfit, :favorites, false
  end

  def when_i_navigate_to_my_style_feed
    visit '/'
  end

  def when_i_toggle_my_like_for_an_item_in_my_style_feed item, recommendation_string
    click_link 'All featured items'
    within :css, "div#all_#{recommendation_string} .like-toggle" do
      find('a').click
    end
  end
end
