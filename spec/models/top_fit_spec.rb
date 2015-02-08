require 'rails_helper'

RSpec.describe TopFit, :type => :model do
  before { @top_fit = TopFit.new(name: 'Oversized') }
  subject { @top_fit }

  it { should respond_to :name }
  it { should be_valid }

  context "when name is not present" do
    before { @top_fit.name = ' ' } 
    it { should_not be_valid }
  end
end
