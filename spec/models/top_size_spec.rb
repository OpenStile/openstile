require 'rails_helper'

RSpec.describe TopSize, :type => :model do

  before { @top_size = TopSize.new(name: "Small", category: "alpha") }

  subject { @top_size }

  it { should respond_to :name }
  it { should respond_to :category }
  it { should respond_to :style_profiles }
  it { should respond_to :retailers }
  it { should be_valid }
end
