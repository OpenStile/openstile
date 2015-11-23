require 'rails_helper'

describe "Retail user resets password" do
  describe "when I log in as a retail user" do
    let(:retail_user) { FactoryGirl.create(:retailer_user, email: "john@example.com" ,
                                                   password: "barbaz",
                                                   password_confirmation: "barbaz")}
    before do
      visit root_path
      click_link 'Log in'
      fill_in 'Email', with: retail_user.email
      fill_in 'Password', with: retail_user.password
      click_button "Log in"
    end

    let(:update) { "Update" }

    it "should show me a link to reset my password" do
      expect(page).to have_link('Reset Password')
    end

    describe "and I click on the reset password link" do
      before do
        click_link "Reset Password"
      end

      it "should take me to the reset password page for retail users" do
        expect(page).to have_title('Edit profile | OpenStile')
        expect(page).to have_content('we need your current password')
      end

      describe "and I enter invalid credentials" do
        before { click_button update }

        it "should take me back to reset password page and show me an error" do
          expect(page).to have_title('Edit profile | OpenStile')
          expect(page).to have_content('prohibited this user from being saved')
        end
      end

      describe "and I enter valid credentials" do

        it 'should allow me to edit my password and maintain my user session' do
          fill_in 'Current password', with: 'barbaz'
          fill_in 'New password', with: 'pass1234'
          fill_in 'Confirm new password', with: 'pass1234'
          click_button update

          expect(page).to have_content('Dashboard')
          expect(page).to have_content("Your account has been updated")
          expect(User.to_adapter.find_first.valid_password?('pass1234')).to be_truthy
        end
      end
    end
  end
end
