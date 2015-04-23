require 'rails_helper'

feature 'Drop in reminder' do
  let(:shopper){ FactoryGirl.create(:shopper) }
  let(:retailer){ FactoryGirl.create(:retailer) }
  let!(:retail_user){ FactoryGirl.create(:retail_user, retailer: retailer) }

  let!(:drop_in_availability) {
    FactoryGirl.create(:standard_availability_in_the_next_hour,
                       retailer: retailer)
  }

  scenario 'shopper/retailer have an impending drop in' do

    # given_i_have_an_impending_drop_in
    impending_drop_in = FactoryGirl.create(:drop_in_scheduled_in_the_next_hour,
                                          retailer: retailer,
                                          shopper: shopper)

    given_the_scheduler_has_run_the_drop_in_reminder_job
    then_i_and_the_retail_user_should_receive_a_reminder_email retail_user.email, shopper.email, impending_drop_in
  end
end
