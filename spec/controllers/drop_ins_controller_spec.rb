require 'rails_helper'

RSpec.describe DropInsController, :type => :controller do
  let(:other_shopper){ FactoryGirl.create(:shopper_user) }
  let(:shopper){ FactoryGirl.create(:shopper_user) }
  let(:retailer){ FactoryGirl.create(:retailer) }
  let(:other_retailer){ FactoryGirl.create(:retailer) }
  let(:retail_user){ FactoryGirl.create(:retailer_user,
                                         retailer: retailer) }
  let(:other_retail_user){ FactoryGirl.create(:retailer_user,
                                         retailer: other_retailer) }
  let!(:drop_in_availability){ FactoryGirl.create(:standard_availability_for_tomorrow,
                                                  retailer: retailer)}
  let(:drop_in){ FactoryGirl.create(:drop_in,
                                    retailer: retailer,
                                    user: shopper,
                                    time: tomorrow_afternoon) }
  before {@request.env["devise.mapping"] = Devise.mappings[:shopper]}

  context "when shopper is not signed in" do
    context "GET upcoming" do
      it "redirects to signin" do
        get :upcoming
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "DELETE destroy" do
      it "redirects to signin" do
        delete :destroy, {id: drop_in.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "PATCH update" do
      it "redirects to signin" do
        patch :update, {id: drop_in.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "PATCH cancel" do
      it "redirects to signin" do
        patch :cancel, {id: drop_in.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  context "when wrong shopper is signed in" do
    before { sign_in other_shopper }  

    context "DELETE destroy" do
      it "redirects to root path" do
        delete :destroy, {id: drop_in.id}
        expect(response).to redirect_to(root_path)
      end
    end

    context "PATCH update" do
      it "redirects to root path" do
        patch :update, {id: drop_in.id}
        expect(response).to redirect_to(root_path)
      end
    end

    context "PATCH cancel" do
      it "redirects to root path" do
        patch :cancel, {id: drop_in.id}
        expect(response).to redirect_to(root_path)
      end
    end
  end

  context "when wrong retail user is signed in" do
    before { sign_in other_retail_user }  

    context "PATCH update" do
      it "redirects to root path" do
        patch :update, {id: drop_in.id}
        expect(response).to redirect_to(root_path)
      end
    end

    context "PATCH cancel" do
      it "redirects to root path" do
        patch :cancel, {id: drop_in.id}
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
