require 'rails_helper'

RSpec.describe Budget, :type => :model do
  let(:shopper){ FactoryGirl.create(:shopper) }
  let(:style_profile){ FactoryGirl.create(:style_profile, shopper: shopper) }

  before do
    @budget = style_profile.budget
  end

  subject { @budget }

  it { should respond_to :style_profile_id }
  it { should respond_to :style_profile }
  it { should respond_to :top_min_price }
  it { should respond_to :top_max_price }
  it { should respond_to :bottom_min_price }
  it { should respond_to :bottom_max_price }
  it { should respond_to :dress_min_price }
  it { should respond_to :dress_max_price }
  it { should respond_to :top_range_string }
  it { should respond_to :bottom_range_string }
  it { should respond_to :dress_range_string }
  it { should be_valid }

  context "when style profile id is not present" do
    before { @budget.style_profile_id = nil }
    it { should_not be_valid }
  end

  describe "top range string" do
    it "should be nil unless top min price and top max price are set" do
      expect(@budget.top_range_string).to be_nil
    end

    it "should update top min price and top max price" do
      @budget.top_range_string = "< $50"
      @budget.save

      expect(@budget.reload.top_min_price).to eq(0.00)
      expect(@budget.reload.top_max_price).to eq(50.00)
    end

    it "should be updated by top min price and top max price" do
      @budget.top_min_price = 0.00
      @budget.top_max_price = 100.00

      expect(@budget.top_range_string).to eq("< $100")
    end
  end

  describe "bottom range string" do
    it "should be nil unless bottom min price and bottom max price are set" do
      expect(@budget.bottom_range_string).to be_nil
    end

    it "should update bottom min price and bottom max price" do
      @budget.bottom_range_string = "$200 +"
      @budget.save

      expect(@budget.reload.bottom_min_price).to eq(200.00)
      expect(@budget.reload.bottom_max_price).to eq(1000.00)
    end

    it "should be updated by bottom min price and bottom max price" do
      @budget.bottom_min_price = 200.00
      @budget.bottom_max_price = 1000.00

      expect(@budget.bottom_range_string).to eq("$200 +")
    end
  end

  describe "dress range string" do
    it "should be nil unless dress min price and dress max price are set" do
      expect(@budget.dress_range_string).to be_nil
    end

    it "should update dress min price and bottom max price" do
      @budget.dress_range_string = "$100 - $150"
      @budget.save

      expect(@budget.reload.dress_min_price).to eq(100.00)
      expect(@budget.reload.dress_max_price).to eq(150.00)
    end

    it "should be updated by dress min price and dress max price" do
      @budget.dress_min_price = 100.00
      @budget.dress_max_price = 150.00

      expect(@budget.dress_range_string).to eq("$100 - $150")
    end
  end
end
