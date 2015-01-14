require 'rails_helper'

RSpec.describe StyleProfile, :type => :model do
  let(:shopper){ FactoryGirl.create(:shopper) }

  before do
    @style_profile = shopper.style_profile
  end
  subject { @style_profile }

  it { should respond_to :shopper_id }
  it { should respond_to :shopper }
  it { should respond_to :top_sizes }
  it { should respond_to :bottom_sizes }
  it { should respond_to :dress_sizes }
  it { should respond_to :budget }
  it { should respond_to :look_tolerances }
  it { should be_valid }

  context "when shopper id is not present" do
    before { @style_profile.shopper_id = nil }
    it { should_not be_valid }
  end

  describe "budget association" do
    it "should create associated budget after create" do
      expect(@style_profile.budget).to_not be_nil
    end

    it "should destroy associated budget" do
      style_profile_budget = @style_profile.budget
      @style_profile.destroy
      expect(style_profile_budget).to_not be_nil
      expect(Budget.where(id: style_profile_budget.id)).to be_empty
    end
  end

  describe "look tolerance association" do
    let(:look){ FactoryGirl.create(:look) }
    let!(:look_tolerance){ FactoryGirl.create(:look_tolerance, 
                               style_profile: @style_profile, 
                               look: look) }

    it "should destroy associated look tolerance" do
      look_tolerances = @style_profile.look_tolerances.to_a
      @style_profile.destroy
      expect(look_tolerances).to_not be_empty
      look_tolerances.each do |lt|
        expect(LookTolerance.where(id: lt.id)).to be_empty
      end
    end
  end
end
