require 'rails_helper'

RSpec.describe BottomFit, :type => :model do
  before { @bottom_fit = BottomFit.new(name: 'Oversized') }
  subject { @bottom_fit }

  it { should respond_to :name }

  context "when name is not present" do
    before { @bottom_fit.name = ' ' } 
    it { should_not be_valid }
  end
end
