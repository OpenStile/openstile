require 'rails_helper'

RSpec.describe Shoppers::RegistrationsController, :type => :controller do

  describe "GET new" do
    before :each do
      @request.env['devise.mapping'] = Devise.mappings[:shopper]
      allow(controller).to receive_messages(:authenticate_shopper? => true)
    end

    it "returns http success" do
      get :new
      expect(response).to be_success
    end
  end

  describe "Successful Signup" do
    before do
      @request.env["devise.mapping"] = Devise.mappings[:shopper]
      sign_in FactoryGirl.create(:shopper)
    end

    it "redirects to the Style Profile edit page" do
      post :create, shopper: FactoryGirl.attributes_for(:shopper)
      expect(response).to redirect_to(style_profiles_edit_path)
    end

    it "should have a current_shopper" do
      # note the fact that I removed the "validate_session" parameter
      # because this was a scaffold-generated controller
      expect(subject.current_shopper).to_not be_nil
    end
  end
end
