require 'rails_helper'

RSpec.describe OutfitsController, :type => :controller do
  let(:outfit){ FactoryGirl.create(:outfit) }

  context "when unauthenticated" do
    context "GET show" do
      it "returns http success" do
        get :show, {id: outfit.id}
        expect(response).to be_success
      end
    end
  end
end
