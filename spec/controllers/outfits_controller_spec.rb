require 'rails_helper'

RSpec.describe OutfitsController, :type => :controller do
  let(:outfit){ FactoryGirl.create(:outfit) }
  let(:retail_user){ FactoryGirl.create(:retail_user, retailer: outfit.retailer) }

  context "when unauthenticated" do
    context "GET show" do
      it "returns http success" do
        get :show, {id: outfit.id}
        expect(response).to be_success
      end
    end

    context "GET toggle_favorites" do
      it "redirects shopper to signin" do
        get :toggle_favorite, {id: outfit.id}
        expect(response).to redirect_to(new_shopper_session_path)
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
        post :create, {outfit: {name: 'Foo', description: 'Bar'}}
        expect(response).to redirect_to(new_admin_session_path)
      end
    end
  end
end
