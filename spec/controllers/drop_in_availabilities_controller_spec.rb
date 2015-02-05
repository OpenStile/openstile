require 'rails_helper'

RSpec.describe DropInAvailabilitiesController, :type => :controller do
  let(:retailer){ FactoryGirl.create(:retailer) }

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
  end

end
