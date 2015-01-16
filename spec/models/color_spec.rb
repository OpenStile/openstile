require 'rails_helper'

RSpec.describe Color, :type => :model do
  
  before { @color = Color.new(name: "White", hexcode: "#ffffff") }

  it { should respond_to :name }
  it { should respond_to :hexcode }
  it { should be_valid }

end
