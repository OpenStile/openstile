require 'rails_helper'

feature 'Retailer user reviews store catalog' do
  let(:retailer){ FactoryGirl.create(:retailer) }
  let(:retail_user){ FactoryGirl.create(:retail_user, retailer: retailer) }
  let!(:top){ FactoryGirl.create(:top, retailer: retailer) }
  let!(:bottom){ FactoryGirl.create(:bottom, retailer: retailer) }
  let!(:dress){ FactoryGirl.create(:dress, retailer: retailer) }

  scenario 'to see offerings' do
    given_i_am_a_logged_in_retail_user retail_user
    when_i_visit_my_store_catalog retailer
    then_i_should_see_product top
    then_i_should_see_product bottom
    then_i_should_see_product dress
    then_i_should_see_product retailer
  end

  def when_i_visit_my_store_catalog retailer
    click_link 'Review store catalog'

    expect(page).to have_content("#{retailer.name} Catalog")
  end

  def then_i_should_see_product recommendation
    expect(page).to have_content(recommendation.name)
  end
end
