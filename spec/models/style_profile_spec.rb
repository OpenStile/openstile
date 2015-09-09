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
  it { should respond_to :part_exposure_tolerances }
  it { should respond_to :hated_colors }
  it { should respond_to :avoided_colors }
  it { should respond_to :avoided_color_ids }
  it { should respond_to :print_tolerances }
  it { should respond_to :body_shape_id }
  it { should respond_to :body_shape }
  it { should respond_to :top_fit }
  it { should respond_to :top_fit_id }
  it { should respond_to :bottom_fit }
  it { should respond_to :bottom_fit_id }
  it { should respond_to :special_considerations }
  it { should respond_to :body_builds }
  it { should respond_to :top_budget }
  it { should respond_to :bottom_budget }
  it { should respond_to :dress_budget }
  it { should respond_to :looks }
  it { should be_valid }

  context "when shopper id is not present" do
    before { @style_profile.shopper_id = nil }
    it { should_not be_valid }
  end

  describe "part exposure association" do
    let(:part){ FactoryGirl.create(:part) }
    let!(:part_exposure_tolerance){ FactoryGirl.create(:part_exposure_tolerance, 
                                                        style_profile: @style_profile, 
                                                        part: part) }

    it "should destroy associated part exposure tolerance" do
      part_exposure_tolerances = @style_profile.part_exposure_tolerances.to_a
      @style_profile.destroy
      expect(part_exposure_tolerances).to_not be_empty
      part_exposure_tolerances.each do |pt|
        expect(PartExposureTolerance.where(id: pt.id)).to be_empty
      end
    end
  end

  describe "hated colors association" do
    let(:color){ FactoryGirl.create(:color) }
    let!(:hated_color){ FactoryGirl.create(:hated_color,
                                           style_profile: @style_profile,
                                           color: color) }

    it "should populate avoided colors for shopper" do
      expect(@style_profile.avoided_colors).to include(color)
      expect(@style_profile.avoided_color_ids).to include(color.id)
    end

    it "should destroy associated hated color" do
      hated_colors = @style_profile.hated_colors.to_a
      @style_profile.destroy
      expect(hated_colors).to_not be_empty
      hated_colors.each do |hc|
        expect(HatedColor.where(id: hc.id)).to be_empty
      end
    end
  end

  describe "print tolerance association" do
    let(:print){ FactoryGirl.create(:print) }
    let!(:print_tolerance){ FactoryGirl.create(:print_tolerance, 
                               style_profile: @style_profile, 
                               print: print) }

    it "should destroy associated print tolerance" do
      print_tolerances = @style_profile.print_tolerances.to_a
      @style_profile.destroy
      expect(print_tolerances).to_not be_empty
      print_tolerances.each do |lt|
        expect(PrintTolerance.where(id: lt.id)).to be_empty
      end
    end
  end
end
