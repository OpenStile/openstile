require 'rails_helper'

RSpec.describe OnlinePresence, :type => :model do
  let(:retailer){ FactoryGirl.create(:retailer) }
  before {@online_presence = retailer.create_online_presence(web_link: "www.example.com") }

  subject { @online_presence }

  it { should respond_to :web_link }
  it { should respond_to :facebook_link }
  it { should respond_to :twitter_link }
  it { should respond_to :instagram_link }
  it { should respond_to :retailer_id }
  it { should respond_to :retailer }
  it { should be_valid }

  context "when retailer id is not present" do
    before { @online_presence.retailer_id = nil }
    it { should_not be_valid }
  end
end
