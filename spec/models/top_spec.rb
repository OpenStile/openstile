require 'rails_helper'

RSpec.describe Top, :type => :model do
  let(:retailer){ FactoryGirl.create(:retailer) }
  before { @top = retailer.tops.build(name: "Green shirt", description: "A really cool shirt",
                                      web_link: "www.see_this_shirt.com", price: 55.00) }
  
  subject { @top }

  it { should respond_to :name }
  it { should respond_to :description }
  it { should respond_to :web_link }
  it { should respond_to :price }
  it { should respond_to :top_sizes }
  it { should respond_to :retailer }
  it { should respond_to :retailer_id }
  it { should be_valid }

  context "when name is not present" do
    before { @top.name = " " }
    it { should_not be_valid }
  end

  context "when description is not present" do
    before { @top.description = " " }
    it { should_not be_valid }
  end

  context "when price is not present" do
    before { @top.price = nil }
    it { should_not be_valid }
  end

  context "when name is too long" do
    before { @top.name = "a"*101 } 
    it { should_not be_valid }
  end

  context "when description is too long" do
    before { @top.description = "a"*251 } 
    it { should_not be_valid }
  end

  context "when web link is too long" do
    before { @top.web_link = "a"*101 } 
    it { should_not be_valid }
  end

  context "when retailer id is not present" do
    before { @top.retailer_id = nil }
    it { should_not be_valid }
  end
end
