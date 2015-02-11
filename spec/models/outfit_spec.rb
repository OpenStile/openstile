require 'rails_helper'

RSpec.describe Outfit, :type => :model do
  let(:retailer){ FactoryGirl.create(:retailer) }
  before do 
    @outfit = retailer.outfits.create(name: 'Really cool shirt and pants',
                      description: 'This awesome combo will make you stand out',
                      price_description: 'Shirt - $50, Pants - $70',
                      average_price: 60.00)
  end
  subject { @outfit }

  it { should respond_to :name }
  it { should respond_to :description }
  it { should respond_to :price_description }
  it { should respond_to :average_price }
  it { should respond_to :top_sizes }
  it { should respond_to :bottom_sizes }
  it { should respond_to :dress_sizes }
  it { should respond_to :retailer }
  it { should respond_to :retailer_id }
  it { should respond_to :look }
  it { should respond_to :look_id }
  it { should respond_to :exposed_parts }
  it { should respond_to :colors }
  it { should respond_to :prints }
  it { should respond_to :body_shape_id }
  it { should respond_to :body_shape }
  it { should respond_to :for_petite }
  it { should respond_to :for_tall }
  it { should respond_to :for_full_figured }
  it { should respond_to :top_fit }
  it { should respond_to :top_fit_id }
  it { should respond_to :bottom_fit }
  it { should respond_to :bottom_fit_id }
  it { should respond_to :special_considerations }
  it { should respond_to :drop_in_items }
  it { should respond_to :image_name }
  it { should respond_to :status }
  it { should respond_to :live? }
  it { should be_valid }

  context "when retailer is not present" do
    before { @outfit.retailer = nil }
    it { should_not be_valid }
  end

  context "when average price is not present" do
    before { @outfit.average_price = nil }
    it { should_not be_valid }
  end

  context "when name is not present" do
    before { @outfit.name = " " }
    it { should_not be_valid }
  end

  context "when name is too long" do
    before { @outfit.name = "a"*101 } 
    it { should_not be_valid }
  end

  context "when description is not present" do
    before { @outfit.description = " " }
    it { should_not be_valid }
  end

  context "when description is too long" do
    before { @outfit.description = "a"*251 } 
    it { should_not be_valid }
  end

  context "when price description is not present" do
    before { @outfit.price_description = " " }
    it { should_not be_valid }
  end

  context "when price description is too long" do
    before { @outfit.price_description = "a"*101 } 
    it { should_not be_valid }
  end

  describe "drop in item association" do
    before { @outfit.save }
    let!(:drop_in_availability) do 
      FactoryGirl.create(:drop_in_availability,
                         retailer: retailer,
                         start_time: tomorrow_morning,
                         end_time: tomorrow_afternoon)
    end
    let(:drop_in){ FactoryGirl.create(:drop_in, 
                                      retailer: retailer,
                                      time: tomorrow_mid_morning) }
    let!(:drop_in_item){ FactoryGirl.create(:drop_in_item,
                                            drop_in: drop_in,
                                            reservable: @outfit)}

    it "should destroy associated drop in items" do
      drop_in_items = @outfit.drop_in_items.to_a
      @outfit.destroy
      expect(drop_in_items).to_not be_empty
      drop_in_items.each do |d|
        expect(DropInItem.where(id: d.id)).to be_empty
      end
    end
  end

  describe "exposed part association" do
    before { @outfit.save }

    let(:part){ FactoryGirl.create(:part) }
    let!(:exposed_part){ FactoryGirl.create(:exposed_part,
                                            exposable: @outfit,
                                            part: part) }

    it "should destroy associated exposed part" do
      exposed_parts = @outfit.exposed_parts.to_a
      @outfit.destroy
      expect(exposed_parts).to_not be_empty
      exposed_parts.each do |ep|
        expect(ExposedPart.where(id: ep.id)).to be_empty
      end
    end
  end

  describe "status" do
    before { @outfit.retailer.status = 1 }

    context "when not set" do
      before { @outfit.status = nil }
      it { should_not be_live }
    end

    context "when it is 1" do
      before { @outfit.status = 1 }

      it { should be_live }

      context "and retailer status not set to 1" do
        before { @outfit.retailer.status = 0 }
        it { should_not be_live }
      end
    end
  end

  describe "image name helper" do
    let(:location){ FactoryGirl.create(:location, 
                                address: "301 Water St. SE, Washington, DC 20003") }
    let(:retailer){ FactoryGirl.create(:retailer, name: "Elena's Boutique")}
    let(:outfit){ FactoryGirl.create(:top, name: "Cool skirt with fun top", retailer: retailer) } 

    it "should return the correct image name" do
      expect(outfit.image_name)
        .to eq("dc_washington_elena_s_boutique_cool_skirt_with_fun_top")
    end
  end
end
