require 'rails_helper'

feature 'Learn about OpenStile' do
  let!(:abc_boutique){ FactoryGirl.create(:retailer,
                                          name: 'ABC Boutique') }
  let!(:chic_boutique){ FactoryGirl.create(:retailer,
                                           name: 'Chic Boutique') }
  let!(:staged_boutique){ FactoryGirl.create(:retailer,
                                             name: 'Not Live Yet Boutique',
                                             status: 0) }

  scenario 'the user experience' do
    given_its_my_first_time_on_OpenStile
    when_i_navigate_to_the_experience_page
    then_i_should_read_about_how_OpenStile_works
    then_i_should_see_partner_stores [abc_boutique, chic_boutique]
    then_i_should_not_see_staged_stores [staged_boutique]
    when_i_view_more_from_store abc_boutique
    then_i_should_be_able_to_signup_for_OpenStile
  end

  def given_its_my_first_time_on_OpenStile
    visit '/'
  end

  def when_i_navigate_to_the_experience_page
    click_link 'The Experience'
  end

  def then_i_should_read_about_how_OpenStile_works
    expect(page).to have_content('run of the mill shopping trip into 
                                  a memorable and enjoyable experience')
  end

  def then_i_should_see_partner_stores stores
    stores.each do |store|
      within(:css, "div#_retailers_#{store.id}") do
        expect(page).to have_link('retailer_log')
      end
    end
  end

  def then_i_should_not_see_staged_stores stores
    stores.each do |store|
      expect(page).to_not have_css("div#_retailers_#{store.id}")
    end
  end

  def when_i_view_more_from_store abc_boutique
    within(:css, "div#_retailers_#{abc_boutique.id}") do
      click_link('retailer_log')
    end
  end

  def then_i_should_be_able_to_signup_for_OpenStile
    click_link 'Start using OpenStile today!'
    expect(page).to have_content("Create an account")
  end
end
