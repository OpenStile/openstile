require 'rails_helper'

RSpec.describe PriceRange, :type => :model do
  let(:retailer){ FactoryGirl.create(:retailer) }

  before do
    @price_range = retailer.build_price_range()
  end

  subject { @price_range }

  it { should respond_to :retailer_id }
  it { should respond_to :retailer }
  it { should respond_to :top_min_price }
  it { should respond_to :top_max_price }
  it { should respond_to :bottom_min_price }
  it { should respond_to :bottom_max_price }
  it { should respond_to :dress_min_price }
  it { should respond_to :dress_max_price }
  it { should be_valid }

  context "when retailer id is not present" do
    before do 
      @price_range.save
      @price_range.retailer_id = nil
    end
    it { should_not be_valid }
  end
end
