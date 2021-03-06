require 'rails_helper'

describe "Shopper sign up" do
  subject { page }
  describe "when I navigate to the sign up page" do
    before do
      visit root_path
      visit '/users/sign_in'
      click_link 'Join now'
    end
    let(:submit) { "Sign up" }

    describe "and enter invalid information" do
      it "should not create a shopper account" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it "should take me back to sign up and show me my errors" do
          expect(page).to have_content("Email can't be blank")
        end
      end
    end

    describe "and I enter valid information" do
      before do
        fill_in "First name", with: "Jane"
        fill_in "Email address",      with: "jane@example.com"
        fill_in "Password", with: "foobarbaz"
        fill_in "Confirm password", with: "foobarbaz"
      end

      it "should create a shopper account" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      it "should send a confirmation email" do
        expect { click_button submit }
                   .to change(ActionMailer::Base.deliveries, :count).by(1)
      end
    end
  end
end
