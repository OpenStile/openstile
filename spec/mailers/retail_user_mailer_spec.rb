require "rails_helper"

RSpec.describe RetailUserMailer, :type => :mailer do
  let(:retailer){ FactoryGirl.create(:retailer) }
  let(:shopper){ FactoryGirl.create(:shopper) }
  let!(:drop_in_availability) {
  FactoryGirl.create(:drop_in_availability,
                     retailer: retailer,
                     location: retailer.location,
                     start_time: tomorrow_morning,
                     end_time: tomorrow_evening)
  }
  let!(:drop_in){ FactoryGirl.create(:drop_in,
                                   shopper: shopper,
                                   retailer: retailer,
                                   time: tomorrow_mid_morning) }

  before(:each) do
    @retail_user = retailer.create_retail_user(retailer_id: retailer.id,
                                              email: "john@example.com",
                                              password: "barbaz",
                                              password_confirmation: "barbaz")
  end

  describe "drop in scheduled email" do
    let(:asserted_mail_method) { RetailUserMailer.drop_in_scheduled_email(retailer, shopper, drop_in) }
    let(:asserted_greeting) { "Hello #{@retail_user.email}" }
    let(:asserted_body) { ["#{greeting}", "#{shopper.first_name} scheduled a drop in for #{drop_in.colloquial_time}",
                            "Check out your drop ins on OpenStile"]}
    let(:asserted_recipient) { @retail_user.email }
    let(:asserted_subject) { "An OpenStile shopper scheduled a drop-in visit with you!" }
    it_behaves_like "a_well_tested_mailer"
  end

  describe "drop in canceled email" do
    let(:asserted_mail_method) { RetailUserMailer.drop_in_canceled_email(retailer, shopper, drop_in) }
    let(:asserted_greeting) { "Hello #{@retail_user.email}" }
    let(:asserted_body) { ["#{greeting}", "Your drop in with #{shopper.first_name} for #{drop_in.colloquial_time} has been canceled.",
                            "Check out your drop ins on OpenStile"]}
    let(:asserted_recipient) { @retail_user.email }
    let(:asserted_subject) { "An OpenStile shopper canceled a drop-in visit!" }
    it_behaves_like "a_well_tested_mailer"
  end

end
