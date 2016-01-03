require 'rails_helper'

RSpec.describe StyleProfilesController, :type => :controller do
  let(:shopper){ FactoryGirl.create(:shopper_user) }
  let(:other_shopper){ FactoryGirl.create(:shopper_user) }
  before {@request.env["devise.mapping"] = Devise.mappings[:shopper]}

  context "when shopper is not signed in" do
    context "GET edit" do
      it "redirects to signin" do
        get :edit, {id: shopper.style_profile.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "PATCH update" do
      it "redirects to signin" do
        patch :update, {id: shopper.style_profile.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  context "when accessing the wrong style profile" do
    before { sign_in other_shopper }  

    context "GET edit" do
      it "redirects to root" do
        get :edit, {id: shopper.style_profile.id}
        expect(response).to redirect_to(root_path)
      end
    end

    context "PATCH update" do
      it "redirects to root" do
        patch :update, {id: shopper.style_profile.id}
        expect(response).to redirect_to(root_path)
      end
    end
  end

  context 'when shopper signed in' do
    before { sign_in shopper }

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

    context "POST quickstart" do
      it "redirects to root" do
        post :quickstart
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
