require 'rails_helper'

RSpec.describe Bottom, :type => :model do
  
  let(:retailer){ FactoryGirl.create(:retailer) }
  before { @bottom = retailer.bottoms.build(name: "Skinny Jeans", description: "A really cool pair of jeans",
                                            web_link: "www.see_these_jeans.com", price: 55.00) }
  
  subject { @bottom }

  it { should respond_to :name }
  it { should respond_to :description }
  it { should respond_to :web_link }
  it { should respond_to :price }
  it { should respond_to :bottom_sizes }
  it { should respond_to :retailer }
  it { should respond_to :retailer_id }
  it { should respond_to :look }
  it { should respond_to :look_id }
  it { should be_valid }

  context "when name is not present" do
    before { @bottom.name = " " }
    it { should_not be_valid }
  end

  context "when description is not present" do
    before { @bottom.description = " " }
    it { should_not be_valid }
  end

  context "when price is not present" do
    before { @bottom.price = nil }
    it { should_not be_valid }
  end

  context "when name is too long" do
    before { @bottom.name = "a"*101 } 
    it { should_not be_valid }
  end

  context "when description is too long" do
    before { @bottom.description = "a"*251 } 
    it { should_not be_valid }
  end

  context "when web link is too long" do
    before { @bottom.web_link = "a"*101 } 
    it { should_not be_valid }
  end

  context "when retailer id is not present" do
    before { @bottom.retailer_id = nil }
    it { should_not be_valid }
  end
end
