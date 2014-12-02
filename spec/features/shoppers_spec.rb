require 'rails_helper'

describe "Shopper pages" do
  subject { page }

  describe "Sign up page" do
    before { visit signup_path }
    let(:submit) { "Sign up" }

    it { should have_selector('h1', text: 'Create an account') }
    it { should have_title('Sign up | OpenStile') }

    describe "with invalid information" do
      it "should not create a shopper account" do
        expect { click_button submit }.not_to change(Shopper, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_title('Sign up | OpenStile') }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do
      before do
        fill_in "First name", with: "Jane"
        fill_in "Email address",      with: "jane@example.com"
        fill_in "Cell phone number",  with: "(703) 555-5555"
        fill_in "Password", with: "foobar"
        fill_in "Confirm password", with: "foobar"
      end

      it "should create a shopper account" do
        expect { click_button submit }.to change(Shopper, :count).by(1)
      end
    end
  end
end
