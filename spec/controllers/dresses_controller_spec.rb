require 'rails_helper'

RSpec.describe DressesController, :type => :controller do
  let(:dress){ FactoryGirl.create(:dress) }

  context "when unauthenticated" do
    context "GET show" do
      it "returns http success" do
        get :show, {id: dress.id}
        expect(response).to be_success
      end
    end
  end
end
