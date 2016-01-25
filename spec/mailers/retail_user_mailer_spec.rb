require "rails_helper"

RSpec.describe RetailUserMailer, :type => :mailer do
  let(:retailer){ FactoryGirl.create(:retailer) }
  let(:shopper){ FactoryGirl.create(:shopper_user) }
  let!(:drop_in_availability) {
  FactoryGirl.create(:standard_availability_for_tomorrow,
                     retailer: retailer,
                     location: retailer.location)
  }
  let!(:drop_in){ FactoryGirl.create(:drop_in,
                                   user: shopper,
                                   retailer: retailer,
                                   time: tomorrow_mid_morning) }

  before(:each) do
    @retail_user = retailer.create_user(retailer_id: retailer.id,
                                              first_name: 'John',
                                              email: "john@example.com",
                                              password: "barbaz",
                                              password_confirmation: "barbaz")
  end

  describe "drop in scheduled email" do
    let(:asserted_mail_method) { RetailUserMailer.drop_in_scheduled_email(drop_in) }
    let(:asserted_greeting) { "Hello #{@retail_user.first_name}" }
    let(:asserted_body) { ["#{greeting}", "#{shopper.first_name} has scheduled a styling with you for #{drop_in.colloquial_time}",
                            "Check out this and all upcoming stylings on OpenStile"]}
    let(:asserted_recipient) { @retail_user.email }
    let(:asserted_subject) { "#{shopper.first_name} has scheduled a styling with you" }
    it_behaves_like "a_well_tested_mailer"
    it 'should have ics attachment' do
      expect(RetailUserMailer.drop_in_scheduled_email(drop_in).attachments).to_not be_empty
    end
  end

  describe "drop in canceled email" do
    let(:asserted_mail_method) { RetailUserMailer.drop_in_canceled_email(drop_in) }
    let(:asserted_greeting) { "Hello #{@retail_user.first_name}" }
    let(:asserted_body) { ["#{greeting}", "#{shopper.first_name} has canceled their styling with you for #{drop_in.colloquial_time}.",
                            "Check out your updated stylings on OpenStile"]}
    let(:asserted_recipient) { @retail_user.email }
    let(:asserted_subject) { "#{shopper.first_name} has canceled a styling with you" }
    it_behaves_like "a_well_tested_mailer"
  end

end
