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
  let!(:size3){ FactoryGirl.create(:bottom_size, name: 'XS', category: 'alpha')}
  let!(:size4){ FactoryGirl.create(:dress_size, name: 'XS', category: 'alpha')}
  let!(:look){ FactoryGirl.create(:look, name: 'Glam_Diva') }
  let!(:print){ FactoryGirl.create(:print, name: 'Animal Prints') }
  let!(:print2){ FactoryGirl.create(:print, name: 'Bold Patterns') }
  let!(:color){ FactoryGirl.create(:print, name: 'Green') }
  let!(:color2){ FactoryGirl.create(:print, name: 'Brown') }
  let!(:shape){ FactoryGirl.create(:body_shape, name: 'Hourglass') }
  let!(:top_fit){ FactoryGirl.create(:top_fit, name: 'Oversized') }
  let!(:bottom_fit){ FactoryGirl.create(:bottom_fit, name: 'Loose/Flowy') }
  let!(:midsection){ FactoryGirl.create(:part, name: 'Midsection') }

  scenario 'creates new retailer' do
    name = 'ABC Boutique'
    owner_name = 'Elvis Presley'
    phone_number = '123-456-7890'

    given_i_am_a_logged_in_admin admin
    given_the_existing_retailers_page_is_empty
    when_i_go_to_add_a_retailer
    when_i_submit_with_invalid_information
    then_it_should_fail_to_add_retailer
    when_i_submit_with_valid_information name, owner_name, phone_number
    then_the_existing_retailers_page_should_contain_retailer name
  end

  scenario 'creates new top' do
    top_name = "Multi-color Halter"
    retailer = FactoryGirl.create(:retailer)

    given_i_am_a_logged_in_admin admin
    when_i_go_to_create_a_top_for_retailer retailer
    when_i_submit_with_invalid_information
    then_it_should_fail_to_add_top
    when_i_submit_item_with_valid_information top_name, :top
    then_the_retailers_catalog_page_should_contain retailer, top_name
  end

  scenario 'creates new bottom' do
    bottom_name = "Distressed Jeans"
    retailer = FactoryGirl.create(:retailer)

    given_i_am_a_logged_in_admin admin
    when_i_go_to_create_a_bottom_for_retailer retailer
    when_i_submit_with_invalid_information
    then_it_should_fail_to_add_bottom
    when_i_submit_item_with_valid_information bottom_name, :bottom
    then_the_retailers_catalog_page_should_contain retailer, bottom_name
  end

  scenario 'creates new dress' do
    dress_name = "Lace, Backless Mini"
    retailer = FactoryGirl.create(:retailer)

    given_i_am_a_logged_in_admin admin
    when_i_go_to_create_a_dress_for_retailer retailer
    when_i_submit_with_invalid_information
    then_it_should_fail_to_add_dress
    when_i_submit_item_with_valid_information dress_name, :dress
    then_the_retailers_catalog_page_should_contain retailer, dress_name
  end

  scenario 'creates new outfit' do
    name = "Checkered print skirt with satin blouse"
    retailer = FactoryGirl.create(:retailer)

    given_i_am_a_logged_in_admin admin
    when_i_go_to_create_an_outfit_for_retailer retailer
    when_i_submit_with_invalid_information
    then_it_should_fail_to_add_outfit
    when_i_submit_outfit_with_valid_information name
    then_the_retailers_catalog_page_should_contain retailer, name
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

  def when_i_go_to_create_a_top_for_retailer retailer
    click_link 'Manage retailers'

    within(:css, "#retailer_#{retailer.id}") do
      click_link 'Add top'
    end

    expect(page).to have_content('Enter top information')
  end

  def when_i_go_to_create_a_dress_for_retailer retailer
    click_link 'Manage retailers'

    within(:css, "#retailer_#{retailer.id}") do
      click_link 'Add dress'
    end

    expect(page).to have_content('Enter dress information')
  end

  def when_i_go_to_create_a_bottom_for_retailer retailer
    click_link 'Manage retailers'

    within(:css, "#retailer_#{retailer.id}") do
      click_link 'Add bottom'
    end

    expect(page).to have_content('Enter bottom information')
  end

  def when_i_go_to_create_an_outfit_for_retailer retailer
    click_link 'Manage retailers'

    within(:css, "#retailer_#{retailer.id}") do
      click_link 'Add outfit'
    end

    expect(page).to have_content('Enter outfit information')
  end

  def when_i_submit_with_invalid_information
    click_button 'Add'
  end

  def then_it_should_fail_to_add_retailer
    expect(page).to have_content('Enter retailer information')
    expect(page).to have_content('error')
  end

  def then_it_should_fail_to_add_top
    expect(page).to have_content('Enter top information')
    expect(page).to have_content('error')
  end

  def then_it_should_fail_to_add_bottom
    expect(page).to have_content('Enter bottom information')
    expect(page).to have_content('error')
  end

  def then_it_should_fail_to_add_dress
    expect(page).to have_content('Enter dress information')
    expect(page).to have_content('error')
  end

  def then_it_should_fail_to_add_outfit
    expect(page).to have_content('Enter outfit information')
    expect(page).to have_content('error')
  end

  def when_i_submit_with_valid_information(name, owner_name, phone_number)
    fill_in 'Name', with: name
    fill_in 'Owner name', with: owner_name
    fill_in 'Phone number', with: phone_number
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

  def when_i_submit_item_with_valid_information name, type
    fill_in 'Name', with: name
    fill_in 'Description', with: 'This is a test item created for demo purposes.'
    fill_in 'Price', with: 59.99
    fill_in 'Web link', with: 'http://example.com'
    choose 'Glam_Diva'
    choose 'Animal Prints'
    choose 'Green'
    choose 'Hourglass'
    check 'For full-figured'
    select 'Oversized', from: 'Top fit' unless type==:bottom
    select 'Loose/Flowy', from: 'Bottom fit' unless type==:top
    check 'Local designers'
    check 'XS'

    click_button 'Add'
  end

  def when_i_submit_outfit_with_valid_information name
    fill_in 'Name', with: name
    fill_in 'Description', with: 'This is an outfit created for demo purposes.'
    fill_in 'Price description', with: 'Skirt $59.00 - Shirt $45.00'
    fill_in 'Average price', with: 52.00
    choose 'Glam_Diva'
    check 'Animal Prints'
    check 'Bold Patterns'
    check 'Green'
    check 'Brown'
    choose 'Hourglass'
    check 'For petite'
    select 'Oversized', from: 'Top fit'
    select 'Loose/Flowy', from: 'Bottom fit'
    check 'Local designers'
    within(:css, '.bottom-sizes') do
      check 'XS'
    end

    click_button 'Add'
  end

  def then_the_existing_retailers_page_should_contain_retailer name
    expect(page).to have_content('OpenStile Retailers')
    expect(page).to have_content('Name')
    expect(page).to have_content(name)
  end

  def then_the_retailers_catalog_page_should_contain retailer, name
    expect(page).to have_content("#{retailer.name} Catalog")
    expect(page).to have_content(name)
  end
end
