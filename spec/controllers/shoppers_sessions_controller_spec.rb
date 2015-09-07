require 'rails_helper'

RSpec.describe Shoppers::SessionsController, :type => :controller do
  let(:shopper){ FactoryGirl.create(:shopper) }
  before {@request.env["devise.mapping"] = Devise.mappings[:shopper]}

  context "when shopper is signed in" do
    before { sign_in shopper }

    context "current_shopper helper" do  
      it "is not nil" do
        expect(controller.send(:current_shopper)).to_not be_nil
      end
    end

    context "shopper_signed_in? helper" do  
      it "returns true" do
        expect(controller.send(:shopper_signed_in?)).to be true
      end
    end

    context "GET new" do
      it "redirects to root" do
        get :new
        expect(response).to redirect_to(upcoming_drop_ins_path)
      end
    end

    context "POST create" do
      it "redirects to root" do
        post :create
        expect(response).to redirect_to(upcoming_drop_ins_path)
      end
    end
  end
end
