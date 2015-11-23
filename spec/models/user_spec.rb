require 'rails_helper'

RSpec.describe User, :type => :model do
  let(:role){FactoryGirl.create(:shopper_role)}
  before { @user = User.new(user_role: role, first_name: "Jane", email: "jane@example.com",
                                  password: "foobar", password_confirmation: "foobar") }

  subject { @user }

  it { should respond_to :first_name }
  it { should respond_to :last_name }
  it { should respond_to :email }
  it { should respond_to :cell }
  it { should respond_to :encrypted_password }
  it { should respond_to :user_role }
  it { should respond_to :style_profile }
  it { should respond_to :drop_ins }
  it { should be_valid }

  context "when first name is not present" do
    before { @user.first_name = " " }
    it { should_not be_valid }
  end

  context "when first name is too long" do
    before { @user.first_name = "a"*51 }
    it { should_not be_valid }
  end

  context "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

  context "when email is too long" do
    before { @user.email = "#{'a'*100}@example.com"}
    it { should_not be_valid }
  end

  context "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo. 
                     foo@bar_baz.com foo@bar+baz.com foo@bar..com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  context "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

  context "when email is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  context "email with mixed case" do
    let(:mixed_case_email) { "FOO@BaR.com" }

    it "should be saved as lower case" do
      @user.email = mixed_case_email
      @user.save
      expect(@user.reload.email).to eq(mixed_case_email.downcase)
    end
  end

  context "when cell phone is blank" do
    before { @user.cell = "" }
    it { should be_valid }
  end

  context "when cell phone format is invalid" do
    it "should be invalid" do
      numbers = %w[123-aaa-5555 123-4563 123-456-789012]
      numbers.each do |number|
        @user.cell = number
        expect(@user).not_to be_valid
      end
    end
  end

  context "when cell phone format is valid" do
    it "should be valid" do
      numbers = ['123-456-7890', '123.456.7890', '1234567890',
                 '(123) 456-7890', '1-123-456-7890']
      numbers.each do |number|
        @user.cell = number
        expect(@user).to be_valid
      end
    end
  end

  context "when password is too short" do
    before { @user.password = @user.password_confirmation = "a"*5 }
    it { should_not be_valid }
  end

  context "when user role is not present" do
    before { @user.user_role = nil }
    it { should_not be_valid }
  end

  context "when retailer user" do
    before do
      @user.user_role = FactoryGirl.create(:retailer_role)
      @user.last_name = 'Doe'
      @user.retailer = FactoryGirl.create(:retailer)
    end

    context "when last name is blank" do
      before { @user.last_name = "" }
      it { should_not be_valid }
    end

    context "when retailer is not present" do
      before { @user.retailer = nil }
      it { should_not be_valid }
    end
  end

  describe "style profile association" do
    before { @user.save }

    it "should create associated style profile after create" do
      expect(@user.style_profile).to_not be_nil
    end

    it "should destroy associated style profile" do
      shopper_style_profile = @user.style_profile
      @user.destroy
      expect(shopper_style_profile).to_not be_nil
      expect(StyleProfile.where(id: shopper_style_profile.id)).to be_empty
    end
  end

  describe "drop ins assocication" do
    before { @user.save }
    let(:retailer){ FactoryGirl.create(:retailer) }
    let!(:drop_in_availability){ FactoryGirl.create(:standard_availability_for_tomorrow,
                                                    retailer: retailer) }
    let!(:drop_in) { FactoryGirl.create(:drop_in,
                                        time: tomorrow_mid_morning,
                                        retailer: retailer,
                                        user: @user) }

    it "should destroy associated drop ins" do
      drop_ins = @user.drop_ins.to_a
      @user.destroy
      expect(drop_ins).to_not be_empty
      drop_ins.each do |d|
        expect(DropIn.where(id: d.id)).to be_empty
      end
    end
  end
end
