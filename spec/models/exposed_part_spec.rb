require 'rails_helper'

RSpec.describe ExposedPart, :type => :model do
  let(:retailer){ FactoryGirl.create(:retailer) }
  let(:top){ FactoryGirl.create(:top, retailer: retailer) }
  let(:part){ FactoryGirl.create(:part) }

  before { @exposed_part = top.exposed_parts.build(part_id: part.id) }

  subject { @exposed_part }

  it { should respond_to :part_id }
  it { should respond_to :part }
  it { should respond_to :exposable_id }
  it { should respond_to :exposable }
  it { should be_valid }

  context "when part id is not present" do
    before { @exposed_part.part_id = nil }

    it { should_not be_valid }
  end

  context "when exposable id is not present" do
    before { @exposed_part.exposable_id = nil }

    it { should_not be_valid }
  end

  describe "polymorphic association" do
    context "when it belongs to a bottom" do
      let(:bottom){ FactoryGirl.create(:bottom, retailer: retailer) }
      before { @exposed_part.exposable = bottom }

      it { should be_valid }
    end

    context "when it belongs to a dress" do
      let(:dress){ FactoryGirl.create(:dress, retailer: retailer) }
      before { @exposed_part.exposable = dress }

      it { should be_valid }
    end
  end
end
