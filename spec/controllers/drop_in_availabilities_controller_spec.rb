require 'rails_helper'

RSpec.describe DropInAvailabilitiesController, :type => :controller do
  let(:retailer){ FactoryGirl.create(:retailer) }
  let(:other_retailer){ FactoryGirl.create(:retailer) }
  let(:wrong_retail_user){ FactoryGirl.create(:retail_user, retailer: other_retailer) }
  before {@request.env["devise.mapping"] = Devise.mappings[:retail_user]}

  context "when retail user is not signed in" do
    describe "GET personal" do
      it "redirects to sign in" do
        get :personal
        expect(response).to redirect_to(new_retail_user_session_path)
      end
    end

    describe "POST create" do
      it "redirects to sign in" do
        post :create, {retailer_id: retailer.id, start_time: tomorrow_morning,
                       end_time: tomorrow_afternoon, bandwidth: 1}
        expect(response).to redirect_to(new_retail_user_session_path)
      end
    end

    describe "PUT update" do
      let!(:drop_in_availability){
        FactoryGirl.create(:drop_in_availability, retailer: retailer)
      }
      it "redirects to sign in" do
        put :update, {id: drop_in_availability.id, drop_in_availability: {bandwidth: 5}}
        expect(response).to redirect_to(new_retail_user_session_path)
      end
    end
  end

  context "when wrong retail user is signed in" do
    before { sign_in wrong_retail_user }  

    describe "PUT update" do
      let!(:drop_in_availability){
        FactoryGirl.create(:drop_in_availability, retailer: retailer)
      }
      it "redirects to root" do
        put :update, {id: drop_in_availability.id, drop_in_availability: {bandwidth: 5}}
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
