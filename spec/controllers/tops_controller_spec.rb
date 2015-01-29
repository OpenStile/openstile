require 'rails_helper'

RSpec.describe TopsController, :type => :controller do
  let(:top){ FactoryGirl.create(:top) }

  context "when unauthenticated" do
    context "GET show" do
      it "returns http success" do
        get :show, {id: top.id}
        expect(response).to be_success
      end
    end
  end
end
