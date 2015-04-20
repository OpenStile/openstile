require "rails_helper"

RSpec.describe ShopperMailer, :type => :mailer do
  let(:retailer){ FactoryGirl.create(:retailer,
                                     phone_number: '2023571818') }
  let(:shopper){ FactoryGirl.create(:shopper) }
  let!(:drop_in_availability) {
  FactoryGirl.create(:standard_availability_for_tomorrow,
                     retailer: retailer,
                     location: retailer.location)
  }
  let!(:drop_in){ FactoryGirl.create(:drop_in,
                                   shopper: shopper,
                                   retailer: retailer,
                                   time: tomorrow_mid_morning) }

  before(:each) do
  end

  describe "drop in scheduled email" do
    let(:asserted_mail_method) { ShopperMailer.drop_in_scheduled_email(retailer, shopper, drop_in) }
    let(:asserted_greeting) { "Hello #{shopper.first_name}" }
    let(:asserted_body) { ["#{greeting}", "We've booked your drop-in at #{retailer.name} for #{drop_in.colloquial_time}",
                            "#{retailer.owner_name} and her team are looking forward to your arrival!",
                            "Should you need to contact them, please call 202-357-1818",
                            "Check out your drop ins on OpenStile"]}
    let(:asserted_recipient) { shopper.email }
    let(:asserted_subject) { "#{retailer.name} is expecting you #{drop_in.colloquial_time}" }
    it_behaves_like "a_well_tested_mailer"
  end

  describe "drop in canceled email" do
    let(:asserted_mail_method) { ShopperMailer.drop_in_canceled_email(retailer, shopper, drop_in) }
    let(:asserted_greeting) { "Hello #{shopper.first_name}" }
    let(:asserted_body) { ["#{greeting}", "You have canceled your drop in with #{retailer.name} for #{drop_in.colloquial_time}",
                            "Hope to catch you another time!",
                            "Check out your drop ins on OpenStile"]}
    let(:asserted_recipient) { shopper.email }
    let(:asserted_subject) { "Your drop-in for #{drop_in.colloquial_time} at #{retailer.name} has been canceled" }
    it_behaves_like "a_well_tested_mailer"
  end

end
