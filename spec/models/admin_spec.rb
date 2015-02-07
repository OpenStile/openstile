require 'rails_helper'

RSpec.describe Admin, :type => :model do
  before { @admin = Admin.new(email: "sysadm@openstile.com",
                              password: "foobar",
                              password_confirmation: "foobar")}

  subject { @admin }

  it { should respond_to :email }
  it { should respond_to :encrypted_password }

  context "when email is not present" do
    before { @admin.email = " " }
    it { should_not be_valid }
 end

  context "when email is too long" do
    before { @admin.email = "#{'a'*100}@example.com"}
    it { should_not be_valid }
  end

  context "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo. 
                     foo@bar_baz.com foo@bar+baz.com foo@bar..com]
      addresses.each do |invalid_address|
        @admin.email = invalid_address
        expect(@admin).not_to be_valid
      end
    end
  end

  context "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @admin.email = valid_address
        expect(@admin).to be_valid
      end
    end
  end

  context "when email is already taken" do
    before do
      user_with_same_email = @admin.dup
      user_with_same_email.email = @admin.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  context "when email with mixed case" do
    let(:mixed_case_email) { "FOO@BaR.com" }

    it "should be saved as lower case" do
      @admin.email = mixed_case_email
      @admin.save
      expect(@admin.reload.email).to eq(mixed_case_email.downcase)
    end
  end

  context "when password is too short" do
    before { @admin.password = @admin.password_confirmation = "a"*5 }
    it { should_not be_valid }
  end
end
