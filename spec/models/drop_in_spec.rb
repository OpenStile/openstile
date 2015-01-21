require 'rails_helper'

RSpec.describe DropIn, :type => :model do
  let(:shopper){ FactoryGirl.create(:shopper) }
  let(:retailer){ FactoryGirl.create(:retailer) }
  before { @drop_in = shopper.drop_ins.create(retailer_id: retailer.id,
                                              time: "2015-01-21 13:43:39") }

  subject { @drop_in }

  it { should respond_to :retailer }
  it { should respond_to :retailer_id }
  it { should respond_to :shopper }
  it { should respond_to :shopper_id }
  it { should respond_to :time }
  it { should be_valid }

  context "when retailer id is not present" do
    before { @drop_in.retailer_id = nil }
    it { should_not be_valid }
  end

  context "when shopper id is not present" do
    before { @drop_in.shopper_id = nil }
    it { should_not be_valid }
  end

  context "when time is not present" do
    before { @drop_in.time = " " }
    it { should_not be_valid }
  end
end
