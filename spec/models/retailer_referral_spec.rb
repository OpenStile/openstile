require 'rails_helper'

RSpec.describe RetailerReferral, :type => :model do

  before { @referral = RetailerReferral.new(referrer_name: 'Jane',
                                            referrer_email: 'jane@example.com',
                                            store_name: 'Chic Boutique',
                                            website: 'www.example.com',
                                            contact_name: 'Jenny',
                                            contact_email: 'jenny@store.com') }

  subject { @referral }

  it { should respond_to :referrer_name }
  it { should respond_to :referrer_email }
  it { should respond_to :store_name }
  it { should respond_to :website }
  it { should respond_to :contact_name }
  it { should respond_to :contact_email }

  context 'when referrer name is not present' do
    before { @referral.referrer_name = ' ' }
    it { should_not be_valid }
  end

  context 'when referrer name is too long' do
    before { @referral.referrer_name = 'a'*101 }
    it { should_not be_valid }
  end

  context 'when contact name is not present' do
    before { @referral.contact_name = ' ' }
    it { should_not be_valid }
  end

  context 'when contact name is too long' do
    before { @referral.contact_name = 'a'*101 }
    it { should_not be_valid }
  end

  context 'when store name is not present' do
    before { @referral.store_name = ' ' }
    it { should_not be_valid }
  end

  context 'when store name is too long' do
    before { @referral.store_name = 'a'*101 }
    it { should_not be_valid }
  end

  context 'when website is not present' do
    before { @referral.website = ' ' }
    it { should_not be_valid }
  end

  context 'when website is too long' do
    before { @referral.website = 'a'*101 }
    it { should_not be_valid }
  end

  context "when referrer email is not present" do
    before { @referral.referrer_email = " " }
    it { should_not be_valid }
  end

  context "when referrer email is too long" do
    before { @referral.referrer_email = "#{'a'*100}@example.com"}
    it { should_not be_valid }
  end

  context "when referrer email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com foo@bar..com]
      addresses.each do |invalid_address|
        @referral.referrer_email = invalid_address
        expect(@referral).not_to be_valid
      end
    end
  end

  context "when referrer email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @referral.referrer_email = valid_address
        expect(@referral).to be_valid
      end
    end
  end

  context "when contact email is not present" do
    before { @referral.contact_email = " " }
    it { should_not be_valid }
  end

  context "when contact email is too long" do
    before { @referral.contact_email = "#{'a'*100}@example.com"}
    it { should_not be_valid }
  end

  context "when contact email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com foo@bar..com]
      addresses.each do |invalid_address|
        @referral.contact_email = invalid_address
        expect(@referral).not_to be_valid
      end
    end
  end

  context "when contact email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @referral.contact_email = valid_address
        expect(@referral).to be_valid
      end
    end
  end
end