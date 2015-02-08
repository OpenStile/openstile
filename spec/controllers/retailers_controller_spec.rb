require 'rails_helper'

RSpec.describe RetailersController, :type => :controller do
  let(:retailer){ FactoryGirl.create(:retailer) }
  let(:retail_user){ FactoryGirl.create(:retail_user, retailer: retailer) }
  before {@request.env["devise.mapping"] = Devise.mappings[:retail_user]}

  context "when unauthenticated" do
    context "GET show" do
      it "returns http success" do
        get :show, {id: retailer.id}
        expect(response).to be_success
      end
    end
  end

  context "when non-admin user signed in" do
    before { sign_in retail_user }

    context "GET index" do
      it "redirects to signin" do
        get :index
        expect(response).to redirect_to(new_admin_session_path)
      end
    end

    context "GET new" do
      it "redirects to signin" do
        get :new
        expect(response).to redirect_to(new_admin_session_path)
      end
    end

    context "POST create" do
      it "redirects to signin" do
        post :create, {retailer: {name: 'Foo', description: 'Bar'}}
        expect(response).to redirect_to(new_admin_session_path)
      end
    end
  end
end
