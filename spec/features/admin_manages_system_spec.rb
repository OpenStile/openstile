require 'rails_helper'

feature 'Admin user manages system' do
  let(:admin){ FactoryGirl.create(:admin) }
  let!(:location){ FactoryGirl.create(:location,
                               address: "1836 Indy Ave. SE, Washington, DC",
                               neighborhood: "Capitol Hill") }
  let!(:second_wear){ FactoryGirl.create(:special_consideration, name: 'Second-wear') }
  let!(:local_designers){ FactoryGirl.create(:special_consideration, name: 'Local designers') }
  let!(:size1){ FactoryGirl.create(:top_size, name: 'XS', category: 'alpha')}
  let!(:size2){ FactoryGirl.create(:top_size, name: '00', category: 'numeric')}

  scenario 'creates new retailer' do
    name = "ABC Boutique"

    given_i_am_a_logged_in_admin admin
    given_the_existing_retailers_page_is_empty
    when_i_go_to_add_a_retailer
    when_i_submit_with_invalid_information
    then_it_should_fail_to_add_retailer
    when_i_submit_with_valid_information name
    then_the_existing_retailers_page_should_contain_retailer name
  end

  def given_the_existing_retailers_page_is_empty
    click_link 'Manage retailers'

    expect(page).to have_content('OpenStile Retailers')
    expect(page).to_not have_content('Name')
  end

  def when_i_go_to_add_a_retailer
    click_link 'Add new retailer'

    expect(page).to have_content('Enter retailer information')
  end

  def when_i_submit_with_invalid_information
    click_button 'Add'
  end

  def then_it_should_fail_to_add_retailer
    expect(page).to have_content('Enter retailer information')
    expect(page).to have_content('error')
  end

  def when_i_submit_with_valid_information name
    fill_in 'Name', with: name
    select '1836 Indy Ave. SE, Washington, DC', from: 'Location'
    fill_in 'Description', with: 'This is a test retailer created for demo purposes.'
    fill_in 'Website', with: 'http://google.com'
    fill_in 'Facebook', with: 'http://facebook.com'
    fill_in 'Instagram', with: 'http://instagram.com'
    fill_in 'Twitter', with: 'http://twitter.com'
    within(:css, '.special-considerations') do
      check 'Second-wear'
      check 'Local designers'
    end
    fill_in 'Top min price', with: '0'
    fill_in 'Top max price', with: '50'
    fill_in 'Bottom min price', with: '0'
    fill_in 'Bottom max price', with: '50'
    fill_in 'Dress min price', with: '0'
    fill_in 'Dress max price', with: '50'
    within(:css, '.top-sizes') do
      check 'XS'
      check '00'
    end
    check 'For petite'

    click_button 'Add'
  end

  def then_the_existing_retailers_page_should_contain_retailer name
    expect(page).to have_content('OpenStile Retailers')
    expect(page).to have_content('Name')
    expect(page).to have_content(name)
  end
end
