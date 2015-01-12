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
  it { should be_valid }

  context "when style profile id is not present" do
    before { @budget.style_profile_id = nil }
    it { should_not be_valid }
  end
end
