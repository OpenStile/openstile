require 'rails_helper'

RSpec.describe Retailer, :type => :model do
  before { @retailer = Retailer.new(name: "ABC Boutique",
                                    neighborhood: "Petworth",
                                    description: "Premier boutique in DC!") }

  subject { @retailer }

  it { should respond_to :name }
  it { should respond_to :neighborhood }
  it { should respond_to :description }
  it { should be_valid }

  context "when name is not present" do
    before { @retailer.name = " " } 
    it { should_not be_valid }
  end

  context "when name is too long" do
    before { @retailer.name = "a"*51 } 
    it { should_not be_valid }
  end

  context "when neighborhood is not present" do
    before { @retailer.neighborhood = " " } 
    it { should_not be_valid }
  end

  context "when neighborhood is too long" do
    before { @retailer.neighborhood = "a"*51 } 
    it { should_not be_valid }
  end

  context "when description is not present" do
    before { @retailer.description = " " } 
    it { should_not be_valid }
  end

  context "when description is too long" do
    before { @retailer.description = "a"*251 } 
    it { should_not be_valid }
  end
end
