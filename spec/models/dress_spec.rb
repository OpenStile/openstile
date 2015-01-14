require 'rails_helper'

RSpec.describe Dress, :type => :model do
  
  before { @dress = Dress.new(name: "Skinny Jeans", description: "A really cool pair of jeans",
                              web_link: "www.see_this_dress.com") }
  
  subject { @dress }

  it { should respond_to :name }
  it { should respond_to :description }
  it { should respond_to :web_link }
  it { should respond_to :dress_sizes }
  it { should be_valid }

  context "when name is not present" do
    before { @dress.name = " " }
    it { should_not be_valid }
  end

  context "when description is not present" do
    before { @dress.description = " " }
    it { should_not be_valid }
  end

  context "when name is too long" do
    before { @dress.name = "a"*101 } 
    it { should_not be_valid }
  end

  context "when description is too long" do
    before { @dress.description = "a"*251 } 
    it { should_not be_valid }
  end

  context "when web link is too long" do
    before { @dress.web_link = "a"*101 } 
    it { should_not be_valid }
  end
end
