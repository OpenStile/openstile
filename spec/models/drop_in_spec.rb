require 'rails_helper'

RSpec.describe DropIn, :type => :model do
  let(:shopper){ FactoryGirl.create(:shopper) }
  let(:retailer){ FactoryGirl.create(:retailer) }
  let!(:drop_in_availability) { 
    FactoryGirl.create(:drop_in_availability, 
                       retailer_id: retailer.id,
                       start_time: DateTime.current,
                       end_time: DateTime.current.advance(hours: 3))
  }
  before { @drop_in = shopper.drop_ins.create(retailer_id: retailer.id,
                                              time: DateTime.current.advance(hour: 1)) }

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

  context "when retailer unavailable" do
    let!(:drop_in_availability){ 
      FactoryGirl.create(:drop_in_availability, retailer: retailer,
                                                start_time: DateTime.current.advance(days: 1),
                                                end_time: DateTime.current.advance(days: 1, hours: 3),
                                                bandwidth: 2) 
    }  

    context "due to not accepting drop ins" do
      before { @drop_in.time = DateTime.current.advance(days: 1, hours: 4) }
      it { should_not be_valid }
    end
    
    context "due to max capacity for drop ins" do
      let!(:drop_in1){ FactoryGirl.create(:drop_in, 
                                          shopper: FactoryGirl.create(:shopper),
                                          retailer: retailer,
                                          time: DateTime.current.advance(days: 1, hours: 1).change(min: 0)) }
      let!(:drop_in2){ FactoryGirl.create(:drop_in, 
                                          shopper: FactoryGirl.create(:shopper),
                                          retailer: retailer,
                                          time: DateTime.current.advance(days: 1, hours: 1).change(min: 0)) }
      before { @drop_in.time = DateTime.current.advance(days: 1, hours: 1).change(min: 0) }
      it { should_not be_valid }
    end
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
