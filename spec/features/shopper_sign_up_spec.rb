require 'rails_helper'

describe "Shopper sign up" do
  subject { page }
  describe "when I navigate to the sign up page" do
    before do
      visit root_path
      click_link 'Sign up'
    end
    let(:submit) { "Sign up" }

    describe "and enter invalid information" do
      it "should not create a shopper account" do
        expect { click_button submit }.not_to change(Shopper, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it "should take me back to sign up and show me my errors" do
          expect(page).to have_title('Sign up | OpenStile')
          expect(page).to have_content("Email can't be blank")
        end
      end
    end

    describe "and I enter valid information" do
      before do
        fill_in "First name", with: "Jane"
        fill_in "Email address",      with: "jane@example.com"
        fill_in "Cell phone number",  with: "(703) 555-5555"
        fill_in "Password", with: "foobarbaz"
        fill_in "Confirm password", with: "foobarbaz"
      end

      it "should create a shopper account" do
        expect { click_button submit }.to change(Shopper, :count).by(1)
      end

      describe "after submission" do
        before { click_button submit }

        it "should take me to edit my Style Profile" do
          expect(page).to have_title('Style Profile | OpenStile')
          expect(page).to have_selector('h2', text: 'My Style Profile')
        end
      end
    end
  end
end