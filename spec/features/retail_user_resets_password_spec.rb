require 'rails_helper'

describe "Retail user resets password" do
  describe "when I log in as a retail user" do
    let(:retail_user) { FactoryGirl.create(:retail_user) }
    before do
      visit root_path
      click_link 'Log in'
      click_link 'Are you a retailer?'
      fill_in 'Email', with: retail_user.email
      fill_in 'Password', with: retail_user.password
      click_button "Log in"
    end
    it "should show me a link to reset my password" do
      expect(page).to have_content('Reset Password')
    end
  end
end