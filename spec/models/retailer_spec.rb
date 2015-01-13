require 'rails_helper'

RSpec.describe Retailer, :type => :model do
  before { @retailer = Retailer.new(name: "ABC Boutique",
                                    neighborhood: "Petworth",
                                    description: "Premier boutique in DC!") }

  subject { @retailer }

  it { should respond_to :name }
  it { should respond_to :neighborhood }
  it { should respond_to :description }
  it { should respond_to :top_sizes }
  it { should respond_to :bottom_sizes }
  it { should respond_to :dress_sizes }
  it { should respond_to :price_range }
  it { should respond_to :primary_look }
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

  describe "price range association" do
    before { @retailer.save }

    it "should create associated price range after create" do
      expect(@retailer.price_range).to_not be_nil
    end

    it "should destroy associated price range" do
      retailer_price_range = @retailer.price_range
      @retailer.destroy
      expect(retailer_price_range).to_not be_nil
      expect(PriceRange.where(id: retailer_price_range.id)).to be_empty
    end
  end
end
