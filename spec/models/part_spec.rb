require 'rails_helper'

RSpec.describe Part, :type => :model do

  before { @part = Part.new(name: "Midsection") }

  subject { @part }

  it { should respond_to :name }
  it { should respond_to :exposed_parts }
  it { should be_valid }

  describe "exposed part association" do
    before { @part.save }

    let(:retailer){ FactoryGirl.create(:retailer) }
    let(:top){ FactoryGirl.create(:top, retailer: retailer) }
    let!(:exposed_part){ FactoryGirl.create(:exposed_part,
                                            exposable: top,
                                            part: @part) }

    it "should destroy associated exposed part" do
      exposed_parts = @part.exposed_parts.to_a
      @part.destroy
      expect(exposed_parts).to_not be_empty
      exposed_parts.each do |ep|
        expect(ExposedPart.where(id: ep.id)).to be_empty
      end
    end
  end
end
