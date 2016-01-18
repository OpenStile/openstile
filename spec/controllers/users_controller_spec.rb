require 'rails_helper'

RSpec.describe Users::UsersController, :type => :controller do
  let(:shopper){ FactoryGirl.create(:shopper_user) }
  let(:retailer){ FactoryGirl.create(:retailer_user) }
  let(:admin){ FactoryGirl.create(:admin_user) }

  context "when not signed in" do
    context "GET shoppers" do
      it "redirects to signin" do
        get :shoppers
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  context 'when shopper signed in' do
    before { sign_in shopper }

    context "GET shoppers" do
      it "redirects to root" do
        get :shoppers
        expect(response).to redirect_to(root_path)
      end
    end
  end

  context 'when retailer signed in' do
    before { sign_in retailer }

    context "GET shoppers" do
      it "redirects to root" do
        get :shoppers
        expect(response).to redirect_to(root_path)
      end
    end
  end
end