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

  context "when user logs in" do
    before do
      @request.env["devise.mapping"] = Devise.mappings[:shopper]
      sign_in FactoryGirl.create(:shopper)
    end

    describe "current_shopper helper" do  
      it "is not nil" do
        expect(controller.send(:current_shopper)).to_not be_nil
      end
    end

    describe "shopper_signed_in? helper" do  
      it "returns true" do
        expect(controller.send(:shopper_signed_in?)).to be true
      end
    end
  end
end
