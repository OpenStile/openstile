require 'rails_helper'

RSpec.describe DropInItem, :type => :model do
  let(:retailer){ FactoryGirl.create(:retailer) }
  let!(:drop_in_availability){ FactoryGirl.create(:drop_in_availability,
                                                  retailer: retailer,
                                                  start_time: tomorrow_morning,
                                                  end_time: tomorrow_afternoon) }
  let(:drop_in){ FactoryGirl.create(:drop_in, retailer: retailer,
                                              time: tomorrow_mid_morning) }
  let(:top){ FactoryGirl.create(:top, retailer: retailer) }
  before { @drop_in_item = drop_in.drop_in_items.build(reservable: top) }

  subject { @drop_in_item }

  it { should respond_to :drop_in }
  it { should respond_to :drop_in_id }
  it { should respond_to :reservable }
  it { should respond_to :reservable_id }
  it { should be_valid }

  context "when drop in id is not present" do
    before { @drop_in_item.drop_in_id = nil }
    it { should_not be_valid }
  end

  context "when reservable id is not present" do
    before { @drop_in_item.reservable_id = nil }
    it { should_not be_valid }
  end

  context "when retailer id for item is not retailer id for drop in" do
    let(:wrong_retailer){ FactoryGirl.create(:retailer) }
    before { @drop_in_item.reservable.retailer_id = wrong_retailer.id }

    it { should_not be_valid }
  end
end
