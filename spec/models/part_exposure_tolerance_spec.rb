require 'rails_helper'

RSpec.describe PartExposureTolerance, :type => :model do
  let(:style_profile){ FactoryGirl.create(:shopper).style_profile }
  let(:part){ FactoryGirl.create(:part) }

  before do
    @part_exposure_tolerance = style_profile.part_exposure_tolerances
                                            .build(part_id: part.id, tolerance: 20)
  end

  subject { @part_exposure_tolerance }

  it { should respond_to :style_profile_id }
  it { should respond_to :style_profile }
  it { should respond_to :part_id }
  it { should respond_to :part }
  it { should be_valid }

  context "when style profile id is not present" do
    before { @part_exposure_tolerance.style_profile_id = nil }
    it { should_not be_valid }
  end

  context "when part id is not present" do
    before { @part_exposure_tolerance.part_id = nil }
    it { should_not be_valid }
  end
end
