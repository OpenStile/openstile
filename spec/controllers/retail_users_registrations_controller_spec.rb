require 'rails_helper'

RSpec.describe RetailUsers::RegistrationsController, :type => :controller do
  let(:retail_user){ FactoryGirl.create(:retail_user) }
  before {@request.env["devise.mapping"] = Devise.mappings[:retail_user]}

  context "when retailer user is signed in" do
    before { sign_in retail_user }

    context "GET edit" do
      it "returns http success" do
        get :edit
        expect(response).to be_success
      end
    end

    context "PATCH update" do
      it "returns http success" do
        patch :update, {id: retail_user.id, retail_user: {password: 'foobar', password_confirmation: 'foobar', current_password: 'whatevs'}}
        expect(response).to be_success
      end
    end
  end

  context "when retail user is not signed in" do
    context "GET edit" do
      it "redirects to signin" do
        get :edit, {id: retail_user.id}
        expect(response).to redirect_to(new_retail_user_session_path)
      end
    end

    context "PATCH update" do
      it "redirects to signin" do
        patch :update, {id: retail_user.id}
        expect(response).to redirect_to(new_retail_user_session_path)
      end
    end
  end
end
