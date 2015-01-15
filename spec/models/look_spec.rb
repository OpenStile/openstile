require 'rails_helper'

RSpec.describe Look, :type => :model do

  before { @look = Look.new(name: "Bohemian Chic") }

  subject { @look }

  it { should respond_to :name }
  it { should respond_to :look_tolerances }
  it { should respond_to :retailers }
  it { should respond_to :tops }
  it { should respond_to :bottoms }
  it { should respond_to :dresses }
  it { should be_valid }

  describe "look tolerance association" do
    before { @look.save }
    let(:style_profile){ FactoryGirl.create(:shopper).style_profile }
    let!(:look_tolerance){ FactoryGirl.create(:look_tolerance, 
                                              style_profile: style_profile, 
                                              look: @look) }

    it "should destroy associated look tolerance" do
      look_tolerances = @look.look_tolerances.to_a
      @look.destroy
      expect(look_tolerances).to_not be_empty
      look_tolerances.each do |lt|
        expect(LookTolerance.where(id: lt.id)).to be_empty
      end
    end
  end
end
