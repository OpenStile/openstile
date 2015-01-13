require 'rails_helper'

RSpec.describe Look, :type => :model do

  before { @look = Look.new(name: "Bohemian Chic") }

  subject { @look }

  it { should be_valid }
end
