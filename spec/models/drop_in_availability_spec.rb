require 'rails_helper'

RSpec.describe DropInAvailability, :type => :model do
  let(:retailer){ FactoryGirl.create(:retailer) }
  before do 
    @drop_in_availability = retailer.drop_in_availabilities
                                    .build(template_date: "2015-01-20",
                                           start_time: "12:00:00",
                                           end_time: "13:00:00",
                                           frequency: "One-time",
                                           bandwidth: 2,
                                           location: retailer.location)
  end

  subject { @drop_in_availability }

  it { should respond_to :retailer }
  it { should respond_to :retailer_id }
  it { should respond_to :start_time }
  it { should respond_to :end_time }
  it { should respond_to :template_date }
  it { should respond_to :frequency }
  it { should respond_to :bandwidth }
  it { should respond_to :location }
  it { should respond_to :location_id }
  it { should be_valid }

  describe "when retailer id is not present" do
    before { @drop_in_availability.retailer_id = nil }
    it { should_not be_valid }
  end

  describe "when start time is not present" do
    before { @drop_in_availability.start_time = " " }
    it { should_not be_valid }
  end

  describe "when end time is not present" do
    before { @drop_in_availability.end_time = " " }
    it { should_not be_valid }
  end

  describe "when template date is not present" do
    before { @drop_in_availability.template_date = " " }
    it { should_not be_valid }
  end

  describe "when frequency is not present" do
    before { @drop_in_availability.frequency = " " }
    it { should_not be_valid }
  end

  describe "when bandwidth is not present" do
    before { @drop_in_availability.bandwidth = " " }
    it { should_not be_valid }
  end

  describe "when end time is earlier than start time" do
    before { @drop_in_availability.end_time = "11:00:00" }
    it { should_not be_valid }
  end

  describe "when location id is not present" do
    before { @drop_in_availability.location_id = nil }
    it { should_not be_valid }
  end

  describe "covers datetime helper function" do
    context "when availability is one-time" do
      it "should correctly evaluate if a datetime is covered" do
        expect(@drop_in_availability.covers_datetime? DateTime.parse("2015-01-20 12:30:00"))
          .to eq(true)
        expect(@drop_in_availability.covers_datetime? DateTime.parse("2015-01-21 12:30:00"))
          .to eq(false)
      end
    end

    context "when availability is weekly" do
      before { @drop_in_availability.frequency = "Weekly" }
      it "should correctly evaluate if a datetime is covered" do
        expect(@drop_in_availability.covers_datetime? DateTime.parse("2015-01-27 12:30:00"))
          .to eq(true)
        expect(@drop_in_availability.covers_datetime? DateTime.parse("2015-01-28 12:30:00"))
          .to eq(false)
      end
    end

    context "when availability is daily" do
      before { @drop_in_availability.frequency = "Daily" }
      it "should correctly evaluate if a datetime is covered" do
        expect(@drop_in_availability.covers_datetime? DateTime.parse("2015-01-21 12:30:00"))
          .to eq(true)
        expect(@drop_in_availability.covers_datetime? DateTime.parse("2015-01-21 13:30:00"))
          .to eq(false)
      end
    end
  end
end
