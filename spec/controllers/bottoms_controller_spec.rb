require 'rails_helper'

RSpec.describe BottomsController, :type => :controller do
  let(:bottom){ FactoryGirl.create(:bottom) }

  context "when unauthenticated" do
    context "GET show" do
      it "returns http success" do
        get :show, {id: bottom.id}
        expect(response).to be_success
      end
    end
  end
end
