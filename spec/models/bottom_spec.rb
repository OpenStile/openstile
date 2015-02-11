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
  it { should respond_to :exposed_parts }
  it { should respond_to :color }
  it { should respond_to :print }
  it { should respond_to :body_shape_id }
  it { should respond_to :body_shape }
  it { should respond_to :for_petite }
  it { should respond_to :for_tall }
  it { should respond_to :for_full_figured }
  it { should respond_to :bottom_fit }
  it { should respond_to :bottom_fit_id }
  it { should respond_to :special_considerations }
  it { should respond_to :drop_in_items }
  it { should respond_to :image_name }
  it { should respond_to :status }
  it { should respond_to :live? }
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

  describe "exposed part association" do
    before { @bottom.save }

    let(:part){ FactoryGirl.create(:part) }
    let!(:exposed_part){ FactoryGirl.create(:exposed_part,
                                            exposable: @bottom,
                                            part: part) }

    it "should destroy associated exposed part" do
      exposed_parts = @bottom.exposed_parts.to_a
      @bottom.destroy
      expect(exposed_parts).to_not be_empty
      exposed_parts.each do |ep|
        expect(ExposedPart.where(id: ep.id)).to be_empty
      end
    end
  end

  describe "drop in item association" do
    before { @bottom.save }
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
                                            reservable: @bottom)}

    it "should destroy associated drop in items" do
      drop_in_items = @bottom.drop_in_items.to_a
      @bottom.destroy
      expect(drop_in_items).to_not be_empty
      drop_in_items.each do |d|
        expect(DropInItem.where(id: d.id)).to be_empty
      end
    end
  end

  describe "status" do
    before { @bottom.retailer.status = 1 }

    context "when not set" do
      before { @bottom.status = nil }
      it { should_not be_live }
    end

    context "when it is 1" do
      before { @bottom.status = 1 }

      it { should be_live }

      context "and retailer status not set to 1" do
        before { @bottom.retailer.status = 0 }
        it { should_not be_live }
      end
    end
  end

  describe "image name helper" do
    let(:location){ FactoryGirl.create(:location, 
                                address: "301 Water St. SE, Washington, DC 20003") }
    let(:retailer){ FactoryGirl.create(:retailer, name: "Elena's Boutique")}
    let(:bottom){ FactoryGirl.create(:bottom, name: "Cool Pants", retailer: retailer) } 

    it "should return the correct image name" do
      expect(bottom.image_name).to eq("dc_washington_elena_s_boutique_cool_pants")
    end
  end
end
