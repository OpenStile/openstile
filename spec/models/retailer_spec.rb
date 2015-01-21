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
  it { should respond_to :online_presence }
  it { should respond_to :drop_in_availabilities }
  it { should respond_to :location }
  it { should respond_to :drop_ins }
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

  describe "online presence association" do
    before { @retailer.save }
    let!(:online_presence){ 
      FactoryGirl.create(:online_presence, retailer: @retailer) 
    }

    it "should destroy associated online presence" do
      retailer_online_presence = @retailer.online_presence
      @retailer.destroy
      expect(retailer_online_presence).to_not be_nil
      expect(OnlinePresence.where(id: retailer_online_presence.id)).to be_empty
    end
  end

  describe "drop in avalabilities assocication" do
    before { @retailer.save }
    let!(:drop_in_availability) { FactoryGirl.create(:drop_in_availability, 
                                                      retailer: @retailer) }

    it "should destroy associated drop in availabilities" do
      drop_in_availabilities = @retailer.drop_in_availabilities.to_a
      @retailer.destroy
      expect(drop_in_availabilities).to_not be_empty
      drop_in_availabilities.each do |d|
        expect(DropInAvailability.where(id: d.id)).to be_empty
      end
    end
  end

  describe "location association" do
    before { @retailer.save }
    let!(:location){ 
      FactoryGirl.create(:location, locatable: @retailer) 
    }

    it "should destroy associated location" do
      retailer_location = @retailer.location
      @retailer.destroy
      expect(retailer_location).to_not be_nil
      expect(Location.where(id: retailer_location.id)).to be_empty
    end
  end

  describe "drop ins assocication" do
    before { @retailer.save }
    let(:shopper){ FactoryGirl.create(:shopper) }
    let!(:drop_in) { FactoryGirl.create(:drop_in, 
                                        retailer: @retailer,
                                        shopper: shopper) }

    it "should destroy associated drop ins" do
      drop_ins = @retailer.drop_ins.to_a
      @retailer.destroy
      expect(drop_ins).to_not be_empty
      drop_ins.each do |d|
        expect(DropIn.where(id: d.id)).to be_empty
      end
    end
  end
end
