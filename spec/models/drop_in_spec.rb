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
  it { should respond_to :drop_in_items }
  it { should respond_to :comment }
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

  context "when comment is too long" do
    before { @drop_in.comment = 'a'*251 }
    it { should_not be_valid }
  end

  describe "drop in item association" do
    before { @drop_in.save }
    let(:top){ FactoryGirl.create(:top, retailer: retailer) }
    let!(:drop_in_item){ FactoryGirl.create(:drop_in_item,
                                            drop_in: @drop_in,
                                            reservable: top)}

    it "should destroy associated drop in items" do
      drop_in_items = @drop_in.drop_in_items.to_a
      @drop_in.destroy
      expect(drop_in_items).to_not be_empty
      drop_in_items.each do |d|
        expect(DropInItem.where(id: d.id)).to be_empty
      end
    end
  end
end
