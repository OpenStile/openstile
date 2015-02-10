require 'rails_helper'

RSpec.describe SpecialConsideration, :type => :model do
  before { @special_consideration = SpecialConsideration.new(name: "Second-wear") }
  subject { @special_consideration }

  it { should respond_to :name }
  it { should respond_to :retailers }
  it { should respond_to :style_profiles }
  it { should respond_to :tops }
  it { should respond_to :bottoms }
  it { should respond_to :dresses }
  it { should respond_to :outfits }
  it { should be_valid }

end
