require 'rails_helper'

describe 'Shopper sign in' do

  before(:each) do
    @shopper = FactoryGirl.create(:shopper)
    visit '/shoppers/sign_in'
 
    fill_in 'Email', with: @shopper.email
    fill_in 'Password', with: @shopper.password
 
    click_button 'Log in'
  end

  it 'allows shoppers to sign in with an email address and password' do
    expect(page).to have_content('Signed in successfully')
    expect(page).to have_link('Log out')
  end

  it 'changes the root_path to style_profiles#edit' do
    expect(current_path).to eq('/style_profiles/edit')
    expect(page).to have_title('Style Profile | OpenStile')
  end

  it 'does not allow an authenticated shopper to log in again' do
    visit '/shoppers/sign_in'

    expect(current_path).to eq('/style_profiles/edit')
    expect(page).to have_content('You are already signed in.')
  end

  it 'allows authenticated shoppers to sign out' do

    visit '/'

    # logout(@shopper)
    click_link 'Log out'

    expect(current_path).to eq('/')
    expect(page).to have_content('Signed out successfully')
    expect(page).to have_title('A Personalized way to Explore Local Fashion Boutiques | OpenStile')
  end
end
