require 'rails_helper'

RSpec.describe Top, :type => :model do

  before { @top = Top.new(name: "Green shirt", description: "A really cool shirt",
                          web_link: "www.see_this_shirt.com") }
  
  subject { @top }

  it { should respond_to :name }
  it { should respond_to :description }
  it { should respond_to :web_link }
  it { should be_valid }

  context "when name is not present" do
    before { @top.name = nil }
    it { should_not be_valid }
  end

  context "when description is not present" do
    before { @top.description = nil }
    it { should_not be_valid }
  end
end
