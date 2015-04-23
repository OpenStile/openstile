require 'rails_helper'

RSpec.describe RetailUser, :type => :model do

  let(:retailer){ FactoryGirl.create(:retailer) }
  before do
    @retail_user = retailer.build_retail_user(email: "john@example.com",
                                              password: "barbaz",
                                              password_confirmation: "barbaz")
  end

  subject { @retail_user }

  it "has a valid factory" do
    expect(FactoryGirl.build(:retail_user)).to be_valid
  end

  it { should respond_to :retailer_id }
  it { should respond_to :retailer }
  it { should respond_to :email }
  it { should respond_to :phone_number }
  it { should respond_to :encrypted_password }
  it { should be_valid }

  context "when retailer is not present" do
    before { @retail_user.retailer = nil }
    it { should_not be_valid }
  end

  context "when email is not present" do
    before { @retail_user.email = " " }
    it { should_not be_valid }
  end

  context "when email is too long" do
    before { @retail_user.email = "#{'a'*100}@example.com"}
    it { should_not be_valid }
  end

  context "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo. 
                     foo@bar_baz.com foo@bar+baz.com foo@bar..com]
      addresses.each do |invalid_address|
        @retail_user.email = invalid_address
        expect(@retail_user).not_to be_valid
      end
    end
  end

  context "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @retail_user.email = valid_address
        expect(@retail_user).to be_valid
      end
    end
  end

  context "when email is already taken" do
    before do
      user_with_same_email = @retail_user.dup
      user_with_same_email.email = @retail_user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  context "when email with mixed case" do
    let(:mixed_case_email) { "FOO@BaR.com" }

    it "should be saved as lower case" do
      @retail_user.email = mixed_case_email
      @retail_user.save
      expect(@retail_user.reload.email).to eq(mixed_case_email.downcase)
    end
  end

  context "when phone number is blank" do
    before { @retail_user.phone_number = "" }
    it { should be_valid }
  end

  context "when phone number format is invalid" do
    it "should be invalid" do
      numbers = %w[123-aaa-5555 123-4563 123-456-789012]
      numbers.each do |number|
        @retail_user.phone_number = number
        expect(@retail_user).not_to be_valid
      end
    end
  end

  context "when phone number format is valid" do
    it "should be valid" do
      numbers = ['123-456-7890', '123.456.7890', '1234567890', 
                 '(123) 456-7890', '1-123-456-7890']
      numbers.each do |number|
        @retail_user.phone_number = number
        expect(@retail_user).to be_valid
      end
    end
  end

  context "when password is too short" do
    before { @retail_user.password = @retail_user.password_confirmation = "a"*5 }
    it { should_not be_valid }
  end
end
