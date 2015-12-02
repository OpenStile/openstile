require 'rails_helper'

RSpec.describe RetailersController, :type => :controller do
  let(:retailer){ FactoryGirl.create(:retailer) }
  let(:retail_user){ FactoryGirl.create(:retailer_user, retailer: retailer) }
  let(:other_owner){ FactoryGirl.create(:retailer_user) }
  before {@request.env["devise.mapping"] = Devise.mappings[:retail_user]}

  context "when unauthenticated" do
    context "GET new" do
      it "redirects to signin" do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "POST create" do
      it "redirects to signin" do
        post :create, {retailer: {name: 'Foo', description: 'Bar'}}
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "GET press_kit" do
      it "redirects to signin" do
        get :press_kit, {id: retailer.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  context "when wrong retail user signed in" do
    before { sign_in other_owner }

    context "GET press_kit" do
      it "redirects to root path" do
        get :press_kit, {id: retailer.id}
        expect(response).to redirect_to(root_path)
      end
    end
  end

  context "when retail user signed in" do
    before { sign_in retail_user }

    context "GET new" do
      it "redirects to signin" do
        get :new
        expect(response).to redirect_to(root_path)
      end
    end

    context "POST create" do
      it "redirects to signin" do
        post :create, {retailer: {name: 'Foo', description: 'Bar'}}
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
