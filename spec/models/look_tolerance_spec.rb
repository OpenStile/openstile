require 'rails_helper'

RSpec.describe LookTolerance, :type => :model do
  let(:style_profile){ FactoryGirl.create(:shopper).style_profile }
  let(:look){ FactoryGirl.create(:look) }

  before do
    @look_tolerance = style_profile.look_tolerances.build(look_id: look.id,
                                                          tolerance: 20)
  end

  subject { @look_tolerance }

  it { should respond_to :style_profile_id }
  it { should respond_to :style_profile }
  it { should respond_to :look_id }
  it { should respond_to :look }
  it { should respond_to :tolerance }
  it { should be_valid }

  context "when style profile id is not present" do
    before { @look_tolerance.style_profile_id = nil }
    it { should_not be_valid }
  end

  context "when look id is not present" do
    before { @look_tolerance.look_id = nil }
    it { should_not be_valid }
  end
end
