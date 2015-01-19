require 'rails_helper'

describe "Shopper log in and log out" do
  describe "when I navigate to the log in page" do
    before do
      visit root_path
      click_link 'Log in'
    end
    let(:shopper) { FactoryGirl.create(:shopper) }
    let(:submit) { "Log in" }

    describe "and I enter invalid credentials" do
      before { click_button submit }

      it "should take me back to log in and show me an error" do
        expect(page).to have_title('Log in | OpenStile')
        expect(page).to have_content("Invalid email or password")
      end

      it "should not log me in" do
        expect(page).to have_link('Log in')
        expect(page).to_not have_link('Log out')
      end
    end

    describe "and I enter valid credentials" do
      before do
        fill_in 'Email', with: shopper.email
        fill_in 'Password', with: shopper.password
 
        click_button submit
      end

      it "should log me in" do
        expect(page).to have_link('Log out')
        expect(page).to_not have_link('Log in')
      end

      it "should take me to my Style Feed" do
        expect(page).to have_content('My Style Feed')
      end

      describe "and I log out after being logged in" do
        before { click_link 'Log out' }

        it "should take me to the home page and notify me that I've been logged out" do
          expect(page).to have_content('Signed out successfully')
          expect(page).to have_title('A Personalized way to Explore Local Fashion Boutiques | OpenStile')
        end

        it "should log me out" do
          expect(page).to have_link('Log in')
          expect(page).to_not have_link('Log out')
        end
      end
    end
  end
end
