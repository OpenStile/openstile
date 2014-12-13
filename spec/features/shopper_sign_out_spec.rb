require 'rails_helper'
include Warden::Test::Helpers

describe "Shopper sign out" do
  
  before(:each) do
    @shopper = FactoryGirl.create(:shopper)
    login_as(@shopper, :scope => :shopper, :run_callbacks => false)
  end

  it "renders the correct page content" do
      visit root_path
      logout(@shopper)

      # expect(page).to have_link('Log in')
      expect(page).to have_title('A Personalized way to Explore Local Fashion Boutiques | OpenStile')
  end
end
