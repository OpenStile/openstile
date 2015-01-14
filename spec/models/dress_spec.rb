require 'rails_helper'

RSpec.describe Dress, :type => :model do
  
  before { @dress = Dress.new(name: "Skinny Jeans", description: "A really cool pair of jeans",
                              web_link: "www.see_this_dress.com") }
  
  subject { @dress }

  it { should respond_to :name }
  it { should respond_to :description }
  it { should respond_to :web_link }
  it { should be_valid }

  context "when name is not present" do
    before { @dress.name = nil }
    it { should_not be_valid }
  end

  context "when description is not present" do
    before { @dress.description = nil }
    it { should_not be_valid }
  end
end
