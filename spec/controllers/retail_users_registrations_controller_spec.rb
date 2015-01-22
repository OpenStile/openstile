require 'rails_helper'

RSpec.describe RetailUsers::RegistrationsController, :type => :controller do
  let(:retail_user){ FactoryGirl.create(:retail_user) }
  before {@request.env["devise.mapping"] = Devise.mappings[:retail_user]}

  context "when retail_user is signed in" do
    before { sign_in retail_user }

    # context "GET new" do
    #   it "redirects to root" do
    #     get :new
    #     expect(response).to redirect_to(root_path)
    #   end
    # end

    # context "POST create" do
    #   it "redirects to root" do
    #     post :create
    #     expect(response).to redirect_to(root_path)
    #   end
    # end
  end
end
