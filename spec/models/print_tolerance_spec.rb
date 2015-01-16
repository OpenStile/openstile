require 'rails_helper'

RSpec.describe PrintTolerance, :type => :model do
  let(:style_profile){ FactoryGirl.create(:shopper).style_profile }
  let(:print){ FactoryGirl.create(:print) }
  before { @print_tolerance = style_profile.print_tolerances.build(print_id: print.id,
                                                                   tolerance: 1)}

  subject{ @print_tolerance}

  it { should respond_to :style_profile }
  it { should respond_to :style_profile_id }
  it { should respond_to :print }
  it { should respond_to :print_id }
  it { should respond_to :tolerance }
  it { should be_valid }

  context "when style profile id is nil" do
    before { @print_tolerance.style_profile_id = nil }
    it { should_not be_valid }
  end

  context "when print id is nil" do
    before { @print_tolerance.print_id = nil }
    it { should_not be_valid }
  end
end
