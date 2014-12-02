require 'rails_helper'

describe "Shopper pages" do
  subject { page }

  describe "Sign up page" do
    before { visit signup_path }

    it { should have_selector('h1', text: 'Create an account') }
    it { should have_title('Sign up | OpenStile') }

    describe "with invalid information" do
      it "should not create a shopper account" do
        expect { click_button "Submit" }.not_to change(Shopper, :count)
      end

      describe "after submission" do
        before { click_button "Submit" }

        it { should have_title('Sign up | OpenStile') }
        it { should have_content('error') }
      end
    end
  end
end
