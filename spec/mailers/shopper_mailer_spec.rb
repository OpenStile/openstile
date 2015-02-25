require "rails_helper"

RSpec.describe ShopperMailer, :type => :mailer do
  let(:retailer){ FactoryGirl.create(:retailer) }
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
    let(:asserted_body) { ["#{greeting}", "You have scheduled a drop in with #{retailer.name} for #{drop_in.colloquial_time}",
                            "Check out your drop ins on OpenStile"]}
    let(:asserted_recipient) { shopper.email }
    let(:asserted_subject) { "You have scheduled a drop-in visit with an OpenStile retailer!" }
    it_behaves_like "a_well_tested_mailer"
  end

  describe "drop in canceled email" do
    let(:asserted_mail_method) { ShopperMailer.drop_in_canceled_email(retailer, shopper, drop_in) }
    let(:asserted_greeting) { "Hello #{shopper.first_name}" }
    let(:asserted_body) { ["#{greeting}", "You have canceled your drop in with #{retailer.name} for #{drop_in.colloquial_time}",
                            "Check out your drop ins on OpenStile"]}
    let(:asserted_recipient) { shopper.email }
    let(:asserted_subject) { "You have canceled a drop-in visit with an OpenStile retailer!" }
    it_behaves_like "a_well_tested_mailer"
  end

end
