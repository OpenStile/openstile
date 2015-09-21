require 'rails_helper'

RSpec.describe BodyBuild, :type => :model do

  before { @body_build = BodyBuild.new(name: 'Petite') }

  subject { @body_build }

  it { should respond_to :name }
  it { should respond_to :style_profiles }

  it { should be_valid }
end
