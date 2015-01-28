require 'rails_helper'

RSpec.describe Location, :type => :model do
  before { @location = Location.new(address: "301 Water St. SE, Washington, DC 20003",
                                    neighborhood: "Navy Yard",
                                    short_title: "Fashion Yards") }
  subject { @location }

  it { should respond_to :address }
  it { should respond_to :neighborhood }
  it { should respond_to :short_title }
  it { should respond_to :retailers }
  it { should respond_to :drop_in_availabilities }
  it { should be_valid } 

  context "when address not present" do
    before { @location.address = " " }
    it { should_not be_valid }
  end

  context "when address is too long" do
    before { @location.address = "a"*101 }
    it { should_not be_valid }
  end

  context "when neighborhood is not present" do
    before { @location.neighborhood = " " }
    it { should_not be_valid }
  end

  context "when neighborhood is too long" do
    before { @location.neighborhood = "a"*51 }
    it { should_not be_valid }
  end

  context "when short title is too long" do
    before { @location.short_title = "a"*101 }
    it { should_not be_valid }
  end

  context "when address is valid format" do
    it "should be valid" do
      addresses = ["301 Water St SE, Washington, DC 20003",
                   "301 Water St SE, Washington, DC",
                   "3rd & Tingey SE, Washington, DC"]
      addresses.each do |valid_address|
        @location.address = valid_address
        expect(@location).to be_valid
      end
    end
  end

  context "when address is invalid format" do
    it "should not be valid" do
      addresses = ["301 Water St", "Water St", "Washington DC"]
      addresses.each do |invalid_address|
        @location.address = invalid_address
        expect(@location).to_not be_valid
        expect(@location.errors.full_messages)
           .to include("Address is invalid format. Try formatting like '1600 Pennsylvania Ave, Washington, DC'")
      end
    end
  end
end
