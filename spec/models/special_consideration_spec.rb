require 'rails_helper'

RSpec.describe SpecialConsideration, :type => :model do
  before { @special_consideration = SpecialConsideration.new(name: "Second-wear") }
  subject { @special_consideration }

  it { should respond_to :name }
  it { should be_valid }
end
