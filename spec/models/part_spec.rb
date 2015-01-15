require 'rails_helper'

RSpec.describe Part, :type => :model do

  before { @part = Part.new(name: "Midsection") }

  subject { @part }

  it { should respond_to :name }
  it { should be_valid }
end
