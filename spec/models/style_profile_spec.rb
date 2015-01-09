require 'rails_helper'

RSpec.describe StyleProfile, :type => :model do
  let(:shopper){ FactoryGirl.create(:shopper) }

  before do
    @style_profile = shopper.build_style_profile
  end
  subject { @style_profile }

  it { should respond_to :shopper_id }
  it { should respond_to :shopper }
  it { should respond_to :top_sizes }
  it { should respond_to :bottom_sizes }
  it { should respond_to :dress_sizes }
  it { should be_valid }

  context "when shopper id is not present" do
    before { @style_profile.shopper_id = nil }
    it { should_not be_valid }
  end
end
