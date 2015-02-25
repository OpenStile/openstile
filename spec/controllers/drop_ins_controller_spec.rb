require 'rails_helper'

RSpec.describe DropInsController, :type => :controller do
  let(:other_shopper){ FactoryGirl.create(:shopper) }
  let(:shopper){ FactoryGirl.create(:shopper) }
  let(:retailer){ FactoryGirl.create(:retailer) }
  let(:retail_user){ FactoryGirl.create(:retail_user) }
  let!(:drop_in_availability){ FactoryGirl.create(:standard_availability_for_tomorrow,
                                                  retailer: retailer)}
  let(:drop_in){ FactoryGirl.create(:drop_in,
                                    retailer: retailer,
                                    shopper: shopper,
                                    time: tomorrow_afternoon) }
  before {@request.env["devise.mapping"] = Devise.mappings[:shopper]}


  context "when shopper is not signed in" do
    context "POST create" do
      it "redirects to signin" do
        post :create, {shopper_id: shopper.id, 
                       retailer_id: retailer.id, 
                       time: "2015-01-21 13:00:00"}
        
        expect(response).to redirect_to(new_shopper_session_path)
      end
    end

    context "GET upcoming" do
      it "redirects to signin" do
        get :upcoming
        expect(response).to redirect_to(new_shopper_session_path)
      end
    end

    context "DELETE destroy" do
      it "redirects to signin" do
        delete :destroy, {id: drop_in.id}
        expect(response).to redirect_to(new_shopper_session_path)
      end
    end

    context "PATCH update" do
      it "redirects to signin" do
        patch :update, {id: drop_in.id}
        expect(response).to redirect_to(new_shopper_session_path)
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
  end

  context "when shopper is signed in" do
    before { sign_in shopper }

    context "GET upcoming" do
      it "should return success" do
        get :upcoming
        expect(response).to be_success
      end
    end
  end

  context "when retail user is signed in" do
    before { sign_in retail_user }

    context "GET upcoming" do
      it "should return success" do
        get :upcoming
        expect(response).to be_success
      end
    end
  end
end
