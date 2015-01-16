require 'rails_helper'

RSpec.describe Dress, :type => :model do
  
  let(:retailer){ FactoryGirl.create(:retailer) }
  before { @dress = retailer.dresses.build(name: "Skinny Jeans", description: "A really cool pair of jeans",
                                           web_link: "www.see_this_dress.com", price: 55.00) }
  
  subject { @dress }

  it { should respond_to :name }
  it { should respond_to :description }
  it { should respond_to :web_link }
  it { should respond_to :price }
  it { should respond_to :dress_sizes }
  it { should respond_to :retailer }
  it { should respond_to :retailer_id }
  it { should respond_to :look }
  it { should respond_to :look_id }
  it { should respond_to :exposed_parts }
  it { should respond_to :color }
  it { should respond_to :print }
  it { should be_valid }

  context "when name is not present" do
    before { @dress.name = " " }
    it { should_not be_valid }
  end

  context "when description is not present" do
    before { @dress.description = " " }
    it { should_not be_valid }
  end

  context "when price is not present" do
    before { @dress.price = nil }
    it { should_not be_valid }
  end

  context "when name is too long" do
    before { @dress.name = "a"*101 } 
    it { should_not be_valid }
  end

  context "when description is too long" do
    before { @dress.description = "a"*251 } 
    it { should_not be_valid }
  end

  context "when web link is too long" do
    before { @dress.web_link = "a"*101 } 
    it { should_not be_valid }
  end

  context "when retailer id is not present" do
    before { @dress.retailer_id = nil }
    it { should_not be_valid }
  end

  describe "exposed part association" do
    before { @dress.save }

    let(:part){ FactoryGirl.create(:part) }
    let!(:exposed_part){ FactoryGirl.create(:exposed_part,
                                            exposable: @dress,
                                            part: part) }

    it "should destroy associated exposed part" do
      exposed_parts = @dress.exposed_parts.to_a
      @dress.destroy
      expect(exposed_parts).to_not be_empty
      exposed_parts.each do |ep|
        expect(ExposedPart.where(id: ep.id)).to be_empty
      end
    end
  end
end
