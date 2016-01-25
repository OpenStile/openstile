require 'rails_helper'

RSpec.describe DropIn, :type => :model do
  let(:shopper){ FactoryGirl.create(:shopper_user, first_name: 'Jane') }
  let(:location){ FactoryGirl.create(:location, address: '123 Some St. Brooklyn, NY 11211')}
  let(:retailer){ FactoryGirl.create(:retailer, name: 'ABC Boutique', location: location) }
  let!(:drop_in_availability) {
    FactoryGirl.create(:standard_availability_for_tomorrow, 
                       retailer: retailer)
  }
  before { @drop_in = shopper.drop_ins.build(retailer_id: retailer.id,
                                             time: tomorrow_mid_morning) }

  subject { @drop_in }

  it { should respond_to :retailer }
  it { should respond_to :retailer_id }
  it { should respond_to :user }
  it { should respond_to :user_id }
  it { should respond_to :time }
  it { should respond_to :comment }
  it { should respond_to :shopper_rating }
  it { should respond_to :retailer_rating }
  it { should respond_to :shopper_feedback }
  it { should respond_to :retailer_feedback }
  it { should respond_to :sales_generated } 
  it { should be_valid }

  context "when retailer is not present" do
    before { @drop_in.retailer = nil }
    it { should_not be_valid }
  end

  context "when user is not present" do
    before { @drop_in.user = nil }
    it { should_not be_valid }
  end

  context "when time is not present" do
    before { @drop_in.time = " " }
    it { should_not be_valid }
  end

  context "when comment is too long" do
    before { @drop_in.comment = 'a'*251 }
    it { should_not be_valid }
  end

  context "when shopper rating is out of range" do
    before { @drop_in.shopper_rating = 6 }
    it { should_not be_valid }
  end

  context "when retailer rating is out of range" do
    before { @drop_in.retailer_rating = 6 }
    it { should_not be_valid }
  end

  context "when shopper feedback is too long" do
    before { @drop_in.shopper_feedback = 'a' * 501 }
    it { should_not be_valid }
  end

  context "when retailer feedback is too long" do
    before { @drop_in.retailer_feedback = 'a' * 501 }
    it { should_not be_valid }
  end

  context "when sales generated is invalid format" do
    it "should be invalid" do
      amounts = ['One million dollars', '99.00.9999', '#$%^&!'] 
      amounts.each do |invalid_amount|
        @drop_in.sales_generated = invalid_amount
        expect(@drop_in).not_to be_valid
      end
    end
  end

  context "when shopper has another drop in at the same time" do
    let!(:other_drop_in){ FactoryGirl.create(:drop_in, 
                                             retailer: retailer,
                                             user: shopper,
                                             time: tomorrow_mid_morning) }
    it { should_not be_valid } 
  end

  context "when retailer unavailable" do
    context "due to not accepting drop ins" do
      before { @drop_in.time = tomorrow_evening }
      it { should_not be_valid }
    end
    
    context "due to max capacity for drop ins" do
      let!(:drop_in1){ FactoryGirl.create(:drop_in, 
                                          user: FactoryGirl.create(:shopper_user),
                                          retailer: retailer,
                                          time: tomorrow_mid_morning.advance(hours: 1)) }
      let!(:drop_in2){ FactoryGirl.create(:drop_in, 
                                          user: FactoryGirl.create(:shopper_user),
                                          retailer: retailer,
                                          time: tomorrow_mid_morning.advance(hours: 1)) }
      before { @drop_in.time = tomorrow_mid_morning.advance(hours: 1) }
      it { should_not be_valid }
    end
  end

  describe 'ics attachment' do
    it 'should be correctly generated for shopper' do
      attachment_params = ['BEGIN:VCALENDAR', 'BEGIN:VEVENT', 'DESCRIPTION:Personal Styling Session with ABC Boutique',
                           "DTSTART:#{tomorrow_mid_morning.utc.strftime('%Y%m%dT%H%M%S')}",
                           "DTEND:#{(tomorrow_mid_morning + 30.minutes).utc.strftime('%Y%m%dT%H%M%S')}",
                           "LOCATION:123 Some St", 'ORGANIZER;CN=OpenStile:mailto:info@openstile.com',
                           'SUMMARY:OpenStile-Styling Session', 'END:VEVENT', 'END:VCALENDAR']
      attachment = @drop_in.ics_attachment(:shopper).to_ical
      attachment_params.each do |param|
        expect(attachment).to match(param)
      end
    end

    it 'should be correctly generated for retailer' do
      attachment_params = ['BEGIN:VCALENDAR', 'BEGIN:VEVENT', 'DESCRIPTION:Personal Styling Session for Jane',
                           "DTSTART:#{tomorrow_mid_morning.utc.strftime('%Y%m%dT%H%M%S')}",
                           "DTEND:#{(tomorrow_mid_morning + 30.minutes).utc.strftime('%Y%m%dT%H%M%S')}",
                           "LOCATION:123 Some St", 'ORGANIZER;CN=OpenStile:mailto:info@openstile.com',
                           'SUMMARY:OpenStile-Styling Session', 'END:VEVENT', 'END:VCALENDAR']
      attachment = @drop_in.ics_attachment(:retailer).to_ical
      attachment_params.each do |param|
        expect(attachment).to match(param)
      end
    end
  end
end
