require 'rails_helper'
include Warden::Test::Helpers

describe "Logout" do
  subject { page }
  
  before(:each) do
    @shopper = FactoryGirl.create(:shopper)
    login_as(@shopper, :scope => :shopper, :run_callbacks => false)
  end

  context "When shopper logs out" do
    describe "it should show the correct content" do
      before do
        visit root_path
        logout(:shopper)
      end

      it { should have_title('A Personalized way to Explore Local Fashion Boutiques | OpenStile') }
    end
  end
end
