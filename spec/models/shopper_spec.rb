require 'rails_helper'
require 'spec_helper'

RSpec.describe Shopper, :type => :model do

  before(:each) do
    @shopper = FactoryGirl.create(:shopper)
  end

  subject { @shopper }

  it { should respond_to :first_name }
  it { should respond_to :email }
  it { should respond_to :cell_phone }
  it { should respond_to :encrypted_password }
  it { should be_valid }

  describe "when first name is not present" do
    before { @shopper.first_name = " " }
    it { should_not be_valid }
  end

  describe "when first name is too long" do
    before { @shopper.first_name = "a"*51 }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @shopper.email = " " }
    it { should_not be_valid }
  end

  describe "when email is too long" do
    before { @shopper.email = "#{'a'*100}@example.com"}
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo. 
                     foo@bar_baz.com foo@bar+baz.com foo@bar..com]
      addresses.each do |invalid_address|
        @shopper.email = invalid_address
        expect(@shopper).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @shopper.email = valid_address
        expect(@shopper).to be_valid
      end
    end
  end

  it "should reject duplicate email addresses" do
    user_with_same_email = @shopper.dup
    user_with_same_email.email = @shopper.email.upcase
    expect(user_with_same_email.valid?).to be(false)
  end

  describe "email with mixed case" do

    before(:each) do
      @shopper_with_mixed_cased_email = FactoryGirl.create(:shopper_with_mixed_cased_email)
    end

    let(:mixed_case_email) { "FOO@BaR.com" }

    it "should be saved as lower case" do
      expect(@shopper_with_mixed_cased_email.email).to eq(mixed_case_email.downcase)
    end
  end

  describe "when cell phone is blank" do
    before { @shopper.cell_phone = "" }
    it { should be_valid }
  end

  describe "when cell phone format is invalid" do
    it "should be invalid" do
      numbers = %w[123-aaa-5555 123-4563 123-456-789012]
      numbers.each do |number|
        @shopper.cell_phone = number
        @shopper.save
        expect(@shopper).not_to be_valid
      end
    end
  end

  describe "when cell phone format is valid" do
    it "should be valid" do
      numbers = ['123-456-7890', '123.456.7890', '1234567890', 
                 '(123) 456-7890', '1-123-456-7890']
      numbers.each do |number|
        @shopper.cell_phone = number
        @shopper.save
        expect(@shopper).to be_valid
      end
    end
  end

  describe "when cell phone format is valid" do
    it "should be format numbers and save them to the database" do
      numbers = ['123-456-7890', '123.456.7890', '1234567890', '(123) 456-7890']
      numbers.each do |number|
        @shopper.cell_phone = number
        @shopper.save
        expect(@shopper.cell_phone).to eq('1234567890')
      end
    end
  end

  describe "when password is too short" do
    before { @shopper.password = @shopper.password_confirmation = "a"*5 }
    it { should_not be_valid }
  end
end
