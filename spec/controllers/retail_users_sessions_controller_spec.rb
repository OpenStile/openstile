require 'rails_helper'

RSpec.describe RetailUsers::SessionsController, :type => :controller do
  # let(:retailer){ FactoryGirl.create(:retailer) }
  let(:retail_user){ FactoryGirl.create(:retail_user) }
  before {@request.env["devise.mapping"] = Devise.mappings[:retail_user]}

  context "when retailer user is signed in" do
    before { sign_in retail_user }

    context "current_retailer_user helper" do  
      it "is not nil" do
        expect(controller.send(:current_retail_user)).to_not be_nil
      end
    end

    context "retailer_signed_in? helper" do  
      it "returns true" do
        expect(controller.send(:retail_user_signed_in?)).to be true
      end
    end

    context "GET new" do
      it "redirects to root" do
        get :new
        expect(response).to redirect_to(root_path)
      end
    end

    context "POST create" do
      it "redirects to root" do
        post :create
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
