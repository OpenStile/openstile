require 'rails_helper'

describe 'Shopper sign in' do

  before(:each) do
    @shopper = FactoryGirl.create(:shopper)
  end
 
  it 'allows shoppers to sign in with an email address and password' do
    visit '/shoppers/sign_in'
 
    fill_in 'Email', with: @shopper.email
    fill_in 'Password', with: @shopper.password
 
    click_button 'Log in'
 
    expect(page).to have_content('Signed in successfully')
  end


  it 'renders the correct page content' do

    visit '/shoppers/sign_in'
 
    fill_in 'Email', with: @shopper.email
    fill_in 'Password', with: @shopper.password
 
    click_button 'Log in'

    expect(page).to have_link('Log out')
    expect(page).to have_title('Style Profile | OpenStile')
  end
end
