require 'rails_helper'

RSpec.describe Top, :type => :model do

  before { @top = Top.new(name: "Green shirt", description: "A really cool shirt",
                          web_link: "www.see_this_shirt.com") }
  
  subject { @top }

  it { should respond_to :name }
  it { should respond_to :description }
  it { should respond_to :web_link }
  it { should respond_to :top_sizes }
  it { should be_valid }

  context "when name is not present" do
    before { @top.name = " " }
    it { should_not be_valid }
  end

  context "when description is not present" do
    before { @top.description = " " }
    it { should_not be_valid }
  end

  context "when name is too long" do
    before { @top.name = "a"*101 } 
    it { should_not be_valid }
  end

  context "when description is too long" do
    before { @top.description = "a"*251 } 
    it { should_not be_valid }
  end

  context "when web link is too long" do
    before { @top.web_link = "a"*101 } 
    it { should_not be_valid }
  end
end
