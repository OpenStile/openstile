require 'rails_helper'

RSpec.describe Look, :type => :model do

  before { @look = Look.new(name: "Bohemian Chic") }

  subject { @look }

  it { should respond_to :name }
  it { should respond_to :image_path }
  it { should respond_to :style_profiles }
  it { should respond_to :retailers }

  it { should be_valid }

end
