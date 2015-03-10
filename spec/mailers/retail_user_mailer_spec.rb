require "rails_helper"

RSpec.describe RetailUserMailer, :type => :mailer do
  let(:retailer){ FactoryGirl.create(:retailer) }
  let(:shopper){ FactoryGirl.create(:shopper) }
  let(:outfit){ FactoryGirl.create(:outfit, retailer: retailer) }
  let!(:drop_in_availability) {
  FactoryGirl.create(:standard_availability_for_tomorrow,
                     retailer: retailer,
                     location: retailer.location)
  }
  let!(:drop_in){ FactoryGirl.create(:drop_in,
                                   shopper: shopper,
                                   retailer: retailer,
                                   time: tomorrow_mid_morning,
                                   comment: 'I want this dress right now!')}

  before(:each) do
    @retail_user = retailer.create_retail_user(retailer_id: retailer.id,
                                              email: "john@example.com",
                                              password: "barbaz",
                                              password_confirmation: "barbaz")
  end

  describe "drop in scheduled email" do
    let(:asserted_mail_method) { RetailUserMailer.drop_in_scheduled_email(retailer, shopper, drop_in, outfit) }
    let(:asserted_greeting) { "Hello #{@retail_user.email}" }
    let(:asserted_body) { ["#{greeting}", "#{shopper.first_name} has scheduled a drop-in at your store for #{drop_in.colloquial_time}",
                            "Here is what she's looking for",
                            "I want this dress right now!",
                            "See more detail on this and all your other upcoming drop-ins on OpenStile"]}
    let(:asserted_recipient) { @retail_user.email }
    let(:asserted_subject) { "#{shopper.first_name} is coming in Tomorrow @ 10 AM" }
    it_behaves_like "a_well_tested_mailer"
  end

  describe "drop in canceled email" do
    let(:asserted_mail_method) { RetailUserMailer.drop_in_canceled_email(retailer, shopper, drop_in) }
    let(:asserted_greeting) { "Hello #{@retail_user.email}" }
    let(:asserted_body) { ["#{greeting}", "Your drop in with #{shopper.first_name} for #{drop_in.colloquial_time} has been canceled.",
                            "Check out your drop ins on OpenStile"]}
    let(:asserted_recipient) { @retail_user.email }
    let(:asserted_subject) { "#{shopper.first_name} has canceled her drop-in for Tomorrow @ 10 AM" }
    it_behaves_like "a_well_tested_mailer"
  end

end
