require 'rails_helper'

feature 'Style Feed' do
  let!(:outfit){ FactoryGirl.create(:outfit) }
  let!(:old_favorite_outfit){ FactoryGirl.create(:outfit, status: 0) }
  let(:shopper){ FactoryGirl.create(:shopper) }

  scenario 'adding and removing favorites', js: true do
    old_favorite_outfit.interested_shoppers << shopper

    given_i_am_a_logged_in_shopper shopper
    when_i_view_favorites_in_style_feed
    then_the_feed_should_not_contain old_favorite_outfit
    then_the_feed_should_not_contain outfit
    when_i_toggle_my_like_for_an_item_in_my_style_feed outfit, "outfits_#{outfit.id}"
    when_i_view_favorites_in_style_feed false
    then_the_feed_should_contain outfit
  end

  def when_i_toggle_my_like_for_an_item_in_my_style_feed item, recommendation_string
    click_link 'Featured items'
    within :css, "div#featured_#{recommendation_string} .like-toggle" do
      find('a').click
    end
  end
end
