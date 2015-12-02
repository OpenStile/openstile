require 'rails_helper'

feature 'Retail user access personalized press kit' do
  let(:store){ FactoryGirl.create(:retailer, name: 'Chic Boutique') }
  let(:owner){ FactoryGirl.create(:retailer_user, retailer: store) }

  scenario 'and is able to share across several platforms' do
    given_i_am_a_logged_in_user owner
    when_i_navigate_to_my_press_kit
    then_i_should_be_able_to_share_on_twitter
    then_i_should_be_able_to_share_on_facebook
    then_i_should_be_able_to_download_image
    then_i_should_be_able_to_embed_decal
  end

  def when_i_navigate_to_my_press_kit
    click_link 'Dashboard'
    click_link 'Press kit'

    expect(page).to have_text('Tell everyone Chic Boutique is on OpenStile')
  end

  def then_i_should_be_able_to_share_on_twitter
    expect(page).to have_text('Share on Twitter')
  end

  def then_i_should_be_able_to_share_on_facebook
    expect(page).to have_text('Share on Facebook')
  end

  def then_i_should_be_able_to_download_image
    expect(page).to have_text("Download share image")
  end

  def then_i_should_be_able_to_embed_decal
    expect(page).to have_text('Embed on site')
  end
end