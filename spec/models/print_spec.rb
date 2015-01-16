require 'rails_helper'

RSpec.describe Print, :type => :model do

  before { @print = Print.new(name: "Animal Print") }

  subject { @print }

  it { should respond_to :name }
  it { should respond_to :print_tolerances }
  it { should respond_to :tops }
  it { should respond_to :bottoms }
  it { should respond_to :dresses }
  it { should be_valid }

  describe "print tolerance association" do
    before { @print.save }
    let(:style_profile){ FactoryGirl.create(:shopper).style_profile }
    let!(:print_tolerance){ FactoryGirl.create(:print_tolerance, 
                               style_profile: style_profile, 
                               print: @print) }

    it "should destroy associated print tolerance" do
      print_tolerances = @print.print_tolerances.to_a
      @print.destroy
      expect(print_tolerances).to_not be_empty
      print_tolerances.each do |lt|
        expect(PrintTolerance.where(id: lt.id)).to be_empty
      end
    end
  end
end
