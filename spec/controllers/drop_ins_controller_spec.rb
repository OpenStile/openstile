require 'rails_helper'

RSpec.describe DropInsController, :type => :controller do
  let(:shopper){ FactoryGirl.create(:shopper) }
  let(:retailer){ FactoryGirl.create(:retailer) }

  context "when shopper is not signed in" do
    context "POST create" do
      it "redirects to signin" do
        post :create, {shopper_id: shopper.id, 
                       retailer_id: retailer.id, 
                       time: "2015-01-21 13:00:00"}
        
        expect(response).to redirect_to(new_shopper_session_path)
      end
    end
  end
end
