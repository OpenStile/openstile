require 'rails_helper'

RSpec.describe RetailersController, :type => :controller do
  let(:retailer){ FactoryGirl.create(:retailer) }

  context "when unauthenticated" do
    context "GET show" do
      it "returns http success" do
        get :show, {id: retailer.id}
        expect(response).to be_success
      end
    end
  end

end
