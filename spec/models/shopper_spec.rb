require 'rails_helper'

RSpec.describe Shopper, :type => :model do
  before { @shopper = Shopper.new(first_name: "Jane", email: "jane@example.com",
                                  password: "foobar", password_confirmation: "foobar") }

  subject { @shopper }

  it { should respond_to :first_name }
  it { should respond_to :email }
  it { should respond_to :cell_phone }
  it { should respond_to :password_digest }
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

  describe "when email is already taken" do
    before do
      user_with_same_email = @shopper.dup
      user_with_same_email.email = @shopper.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "email with mixed case" do
    let(:mixed_case_email) { "FOO@BaR.com" }

    it "should be saved as lower case" do
      @shopper.email = mixed_case_email
      @shopper.save
      expect(@shopper.reload.email).to eq(mixed_case_email.downcase)
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
        expect(@shopper).to be_valid
      end
    end
  end

  describe "when password is too short" do
    before { @shopper.password = @shopper.password_confirmation = "a"*5 }
    it { should_not be_valid }
  end
end
