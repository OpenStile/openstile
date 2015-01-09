require 'rails_helper'

RSpec.describe BottomSize, :type => :model do

  before { @bottom_size = BottomSize.new(name: "Small", category: "alpha") }

  subject { @bottom_size }

  it { should respond_to :name }
  it { should respond_to :category }
  it { should respond_to :style_profiles }
  it { should be_valid }
end
