require 'rails_helper'

RSpec.describe Shoppers::RegistrationsController, :type => :controller do

  before { allow(controller).to receive_messages(:authenticate_shopper? => true)}

  describe "GET new" do
    before :each do
      @request.env['devise.mapping'] = Devise.mappings[:shopper]
    end

    it "returns http success" do

      get :new
      expect(response).to be_success
    end
  end

end
