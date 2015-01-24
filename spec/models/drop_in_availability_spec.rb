require 'rails_helper'

RSpec.describe DropInAvailability, :type => :model do
  let(:retailer){ FactoryGirl.create(:retailer) }
  before do 
    @drop_in_availability = retailer.drop_in_availabilities
                                    .build(start_time: "2015-01-20 12:00:00",
                                           end_time: "2015-01-20 13:00:00",
                                           bandwidth: 2)
  end

  subject { @drop_in_availability }

  it { should respond_to :retailer }
  it { should respond_to :retailer_id }
  it { should respond_to :start_time }
  it { should respond_to :end_time }
  it { should respond_to :bandwidth }
  it { should respond_to :location }
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

  describe "when bandwidth is not present" do
    before { @drop_in_availability.bandwidth = " " }
    it { should_not be_valid }
  end

  describe "when start time and end time are on different days" do
    before { @drop_in_availability.end_time = "2015-01-21 13:00:00" }
    it { should_not be_valid }
  end

  describe "when end time is earlier than start time" do
    before { @drop_in_availability.end_time = "2015-01-20 11:00:00" }
    it { should_not be_valid }
  end

  describe "location association" do
    before { @drop_in_availability.save }
    let!(:location){ 
      FactoryGirl.create(:location, locatable: @drop_in_availability) 
    }

    it "should destroy associated location" do
      drop_in_availability_location = @drop_in_availability.location
      @drop_in_availability.destroy
      expect(drop_in_availability_location).to_not be_nil
      expect(Location.where(id: drop_in_availability_location.id)).to be_empty
    end
  end
end
