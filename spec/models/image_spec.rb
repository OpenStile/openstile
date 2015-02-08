require 'rails_helper'

RSpec.describe Image, :type => :model do

  let(:retailer){ FactoryGirl.create(:retailer) }
  before do
    @image = retailer.build_image(name: "dc_washington_pfeffer_wall_boutique",
                      url: "http://res.cloudinary.com/openstile-test/image/upl...",
                      height: 500, width: 500, format: "jpg")
  end

subject { @image }

  it { should respond_to :name }
  it { should respond_to :url }
  it { should respond_to :height }
  it { should respond_to :width }
  it { should respond_to :url }
  it { should be_valid }

  context "when name is not present" do
    before { @image.name = " " }
    it { should_not be_valid }
  end

  context "when first name is too long" do
    before { @image.name = "a"*51 }
    it { should_not be_valid }
  end

  context "when url is not present" do
    before { @image.url = " " }
    it { should_not be_valid }
  end

  context "when height is not present" do
    before { @image.url = " " }
    it { should_not be_valid }
  end

  context "when width is not present" do
    before { @image.url = " " }
    it { should_not be_valid }
  end

  context "when format is not present" do
    before { @image.url = " " }
    it { should_not be_valid }
  end

  context "when image format is invalid" do
    before do
      @another_image = retailer.build_image(name: "dc_washington_pfeffer_wall_boutique",
                      url: "http://res.cloudinary.com/openstile-test/image/upl...",
                      height: 500, width: 500, format: "png")
    end
    it "should be invalid" do
      expect(@another_image).to_not be_valid
    end
  end

end
