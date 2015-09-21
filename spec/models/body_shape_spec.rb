require 'rails_helper'

RSpec.describe BodyShape, :type => :model do
  before { @body_shape = BodyShape.new(name: "Apple", description: "Widest in the middle")}
  subject { @body_shape }

  it { should respond_to :name }
  it { should respond_to :description }
  it { should respond_to :style_profiles }
  it { should respond_to :retailers }

  it { should be_valid }

end
