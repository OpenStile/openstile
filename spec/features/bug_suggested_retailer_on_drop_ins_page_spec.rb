require 'rails_helper'

feature 'Shopper views suggested retailers' do
  let(:staged_retailer){ FactoryGirl.create(:retailer,
                                             status: 0) }
  let(:shopper){ FactoryGirl.create(:shopper) } 

  scenario 'when staged retailer' do
    baseline_calibration_for_shopper_and_retailers
    
    given_i_am_a_logged_in_shopper shopper
    given_i_have_no_drop_ins_scheduled
    then_i_should_not_see_a_suggested_retailer
  end

  def then_i_should_not_see_a_suggested_retailer
    expect(page).to_not have_content('based on your preferences we suggest')
  end

  private
    def baseline_calibration_for_shopper_and_retailers
      shared_size = FactoryGirl.create(:top_size)
      shopper.style_profile.top_sizes << shared_size
      staged_retailer.top_sizes << shared_size

      shopper.style_profile.budget.update!(top_min_price: 50.00, top_max_price: 100.00)
      staged_retailer.create_price_range!(top_min_price: 50.00, top_max_price: 100.00)
    end
end
