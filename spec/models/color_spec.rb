require 'rails_helper'

RSpec.describe Color, :type => :model do
  
  before { @color = Color.new(name: "White", hexcode: "#ffffff") }

  subject { @color }

  it { should respond_to :name }
  it { should respond_to :hexcode }
  it { should respond_to :hated_colors }
  it { should respond_to :tops }
  it { should respond_to :bottoms }
  it { should respond_to :dresses }
  it { should respond_to :outfits }
  it { should be_valid }


  describe "hated colors association" do
    before { @color.save }
    let(:style_profile){ FactoryGirl.create(:shopper).style_profile }
    let!(:hated_color){ FactoryGirl.create(:hated_color,
                                           style_profile: style_profile,
                                           color: @color) }

    it "should destroy associated hated color" do
      hated_colors = @color.hated_colors.to_a
      @color.destroy
      expect(hated_colors).to_not be_empty
      hated_colors.each do |hc|
        expect(HatedColor.where(id: hc.id)).to be_empty
      end
    end
  end
end
