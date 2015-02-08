require 'rails_helper'

RSpec.describe TopsController, :type => :controller do
  let(:top){ FactoryGirl.create(:top) }
  let(:retail_user){ FactoryGirl.create(:retail_user, retailer: top.retailer) }

  context "when unauthenticated" do
    context "GET show" do
      it "returns http success" do
        get :show, {id: top.id}
        expect(response).to be_success
      end
    end
  end

  context "when non-admin user is signed in" do
    before { sign_in retail_user }

    context "GET new" do
      it "redirects to signin" do
        get :new
        expect(response).to redirect_to(new_admin_session_path)
      end
    end

    context "POST create" do
      it "redirects to signin" do
        post :create, {top: {name: 'Foo', description: 'Bar'}}
        expect(response).to redirect_to(new_admin_session_path)
      end
    end
  end
end
