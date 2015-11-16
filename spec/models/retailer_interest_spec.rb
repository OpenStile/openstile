require 'rails_helper'

RSpec.describe RetailerInterest, :type => :model do
  let(:admin){ FactoryGirl.create(:admin) }

  it { should respond_to :boutique_name }
  it { should respond_to :first_name}
  it { should respond_to :last_name}
  it { should respond_to :street_address }
  it { should respond_to :city }
  it { should respond_to :state }
  it { should respond_to :zip_code }
  it { should respond_to :email_address }
  it { should respond_to :phone_number }
  it { should respond_to :website_address }
  it { should respond_to :describe_store_aesthetic }

  # context ""

  # context "when I apply to be an openstile boutique" do

  context "when boutique name is not present" do
    before { @retailer_interest.boutique_name = " " }
    it { should_not be_valid }
  end

  context "when email is not present" do
    before { @retailer_interest.email = " " }
    it { should_not be_valid }
  end

  context "when email is too long" do
    before { @retailer_interest.email = "#{'a'*100}@example.com"}
    it { should_not be_valid }
  end

  context "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo.com user_at_foo.org example.user@foo. 
                     foo@bar_baz.com foo@bar+baz.com foo@bar..com]
      addresses.each do |invalid_address|
        @retailer_interest.email = invalid_address
        expect(@retailer_interest).not_to be_valid
      end
    end
  end

  context "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @retailer_interest.email = valid_address
        expect(@retailer_interest).to be_valid
      end
    end
  end
end
  	