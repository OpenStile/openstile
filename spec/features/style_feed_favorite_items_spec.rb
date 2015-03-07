require 'rails_helper'

feature 'Style Feed' do
  let(:outfit){ FactoryGirl.create(:outfit) }
  let(:shopper){ FactoryGirl.create(:shopper) }

  scenario 'adding and removing favorites', js: true do
    given_i_am_a_logged_in_shopper shopper
    when_i_like_an_item_in_my_style_feed outfit
    then_my_style_feed_should_contain outfit, :favorites
    when_i_unlike_an_item_in_my_style_feed outfit
    then_my_style_feed_should_not_contain outfit, :favorites
  end

  def when_i_like_an_item_in_my_style_feed outfit
    visit '/'
    click_link 'All items'
  end

  def when_i_unlike_an_item_in_my_style_feed outfit
    visit '/'
    click_link 'All items'
  end
end
