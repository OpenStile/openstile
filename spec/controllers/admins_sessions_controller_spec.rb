require 'rails_helper'

RSpec.describe Admins::SessionsController, :type => :controller do
  let(:admin){ FactoryGirl.create(:admin) }
  before {@request.env["devise.mapping"] = Devise.mappings[:admin]}

  context "when admin is signed in" do
    before { sign_in admin }

    context "current_admin helper" do  
      it "is not nil" do
        expect(controller.send(:current_admin)).to_not be_nil
      end
    end

    context "admin_signed_in? helper" do  
      it "returns true" do
        expect(controller.send(:admin_signed_in?)).to be true
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
