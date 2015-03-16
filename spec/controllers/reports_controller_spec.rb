require 'rails_helper'

RSpec.describe ReportsController, :type => :controller do
  let(:shopper){ FactoryGirl.create(:shopper) } 

  context "when unauthenticated" do
    describe "GET new" do
      it "redirects to admin signin" do
        get :new
        expect(response).to redirect_to(new_admin_session_path)
      end
    end

    describe "POST create" do
      it "returns http success" do
        post :create, {start: "2015-02-14", end: "2015-02-21"}
        expect(response).to redirect_to(new_admin_session_path)
      end
    end
  end

  context "when non-admin user is signed in" do
    before { sign_in shopper }

    describe "GET new" do
      it "redirects to admin signin" do
        get :new
        expect(response).to redirect_to(new_admin_session_path)
      end
    end

    describe "POST create" do
      it "returns http success" do
        post :create, {start: "2015-02-14", end: "2015-02-21"}
        expect(response).to redirect_to(new_admin_session_path)
      end
    end
  end
end
