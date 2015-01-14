require 'rails_helper'

RSpec.describe Bottom, :type => :model do
  
  before { @bottom = Bottom.new(name: "Skinny Jeans", description: "A really cool pair of jeans",
                                web_link: "www.see_these_jeans.com") }
  
  subject { @bottom }

  it { should respond_to :name }
  it { should respond_to :description }
  it { should respond_to :web_link }
  it { should be_valid }

  context "when name is not present" do
    before { @bottom.name = nil }
    it { should_not be_valid }
  end

  context "when description is not present" do
    before { @bottom.description = nil }
    it { should_not be_valid }
  end
end
