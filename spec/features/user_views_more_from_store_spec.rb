require 'rails_helper'

feature 'User views more from store' do
  let(:retailer){ FactoryGirl.create(:retailer, name: 'ABC Boutique') }
  let!(:top){ FactoryGirl.create(:top, status: 0, retailer: retailer) }
  let!(:bottom){ FactoryGirl.create(:bottom, retailer: retailer) }
  let!(:dress){ FactoryGirl.create(:dress, retailer: retailer) }
  let!(:outfit){ FactoryGirl.create(:outfit, retailer: retailer) }

  scenario 'when on the retailer page' do
    given_i_am_viewing_the_details_page "/retailers/#{retailer.id}"
    then_i_should_see_the_view_more_scroll_for 'ABC Boutique'
    then_i_should_not_see_the_view_more_link_for top
    when_i_click_on_the_view_more_link_for bottom
    then_i_should_see_details_for bottom
  end

  scenario 'when on an item page' do
    given_i_am_viewing_the_details_page "/outfits/#{outfit.id}"
    then_i_should_see_the_view_more_scroll_for 'ABC Boutique'
    then_i_should_not_see_the_view_more_link_for top
    when_i_click_on_the_view_more_link_for dress
    then_i_should_see_details_for dress
  end

  def given_i_am_viewing_the_details_page path
    visit path
  end

  def then_i_should_see_the_view_more_scroll_for name
    expect(page).to have_content("See more from #{name}")
  end

  def when_i_click_on_the_view_more_link_for item
    click_link(item.image_alt_text)
  end

  def then_i_should_not_see_the_view_more_link_for item
    expect(page.has_link?(item.image_alt_text)).to be(false)
  end

  def then_i_should_see_details_for item
    expect(page).to have_content(item.name)
    expect(page).to have_content(item.description)
  end
end
