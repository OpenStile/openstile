require 'rails_helper'

RSpec.describe HatedColor, :type => :model do
  let(:style_profile){ FactoryGirl.create(:shopper).style_profile }
  let(:color){ FactoryGirl.create(:color) }

  before { @hated_color = style_profile.hated_colors.build(color_id: color.id) }

  subject { @hated_color }

  it { should respond_to :style_profile_id }
  it { should respond_to :style_profile }
  it { should respond_to :color_id }
  it { should respond_to :color }
  it { should be_valid }

  context "when style profile id is not present" do
    before { @hated_color.style_profile_id = nil }
    it { should_not be_valid }
  end

  context "when color id is not present" do
    before { @hated_color.color_id = nil }
    it { should_not be_valid }
  end
end
