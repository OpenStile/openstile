require 'rails_helper'

RSpec.describe Part, :type => :model do

  before { @part = Part.new(name: "Midsection") }

  subject { @part }

  it { should respond_to :name }
  it { should respond_to :part_exposure_tolerances }
  it { should be_valid }

  describe "part exposure association" do
    before { @part.save }

    let(:style_profile){ FactoryGirl.create(:shopper).style_profile }
    let!(:part_exposure_tolerance){ FactoryGirl.create(:part_exposure_tolerance, 
                                                        style_profile: style_profile, 
                                                        part: @part) }

    it "should destroy associated part exposure tolerance" do
      part_exposure_tolerances = @part.part_exposure_tolerances.to_a
      @part.destroy
      expect(part_exposure_tolerances).to_not be_empty
      part_exposure_tolerances.each do |pt|
        expect(PartExposureTolerance.where(id: pt.id)).to be_empty
      end
    end
  end
end
