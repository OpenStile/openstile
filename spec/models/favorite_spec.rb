require 'rails_helper'

RSpec.describe Favorite, :type => :model do
  let(:shopper){ FactoryGirl.create(:shopper) }
  let(:retailer){ FactoryGirl.create(:retailer) }
  let(:outfit){ FactoryGirl.create(:outfit, retailer: retailer) }

  before { @favorite = shopper.favorites.build(favoriteable: outfit) }

  subject { @favorite }

  it { should respond_to :shopper }
  it { should respond_to :shopper_id }
  it { should respond_to :favoriteable }
  it { should respond_to :favoriteable_id }
  it { should be_valid }

  context "when shopper is not present" do
    before { @favorite.shopper = nil }
    it { should_not be_valid }
  end

  context "when favoriteable is not present" do
    before { @favorite.favoriteable = nil }
    it { should_not be_valid }
  end
end
