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
  it { should respond_to :look }
  it { should respond_to :look_id }
  it { should respond_to :primary_look }
  it { should respond_to :tops }
  it { should respond_to :bottoms }
  it { should respond_to :dresses }
  it { should respond_to :body_shape_id }
  it { should respond_to :body_shape }
  it { should respond_to :for_petite }
  it { should respond_to :for_tall }
  it { should respond_to :for_full_figured }
  it { should respond_to :top_fit }
  it { should respond_to :bottom_fit }
  it { should respond_to :special_considerations }
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

  describe "tops assocication" do
    before { @retailer.save }
    let!(:top) { FactoryGirl.create(:top, retailer: @retailer) }

    it "should destroy associated tops" do
      tops = @retailer.tops.to_a
      @retailer.destroy
      expect(tops).to_not be_empty
      tops.each do |t|
        expect(Top.where(id: t.id)).to be_empty
      end
    end
  end

  describe "bottoms assocication" do
    before { @retailer.save }
    let!(:bottom) { FactoryGirl.create(:bottom, retailer: @retailer) }

    it "should destroy associated bottoms" do
      bottoms = @retailer.bottoms.to_a
      @retailer.destroy
      expect(bottoms).to_not be_empty
      bottoms.each do |b|
        expect(Bottom.where(id: b.id)).to be_empty
      end
    end
  end

  describe "dresses assocication" do
    before { @retailer.save }
    let!(:dress) { FactoryGirl.create(:dress, retailer: @retailer) }

    it "should destroy associated dresses" do
      dresses = @retailer.dresses.to_a
      @retailer.destroy
      expect(dresses).to_not be_empty
      dresses.each do |d|
        expect(Dress.where(id: d.id)).to be_empty
      end
    end
  end
end
