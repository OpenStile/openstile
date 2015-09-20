require 'rails_helper'

feature 'Retailer interest form' do
let!(:admin){ FactoryGirl.create(:admin)}
let(:retailer){ FactoryGirl.create(:retailer) }

scenario 'form submision details' do
given_i_am_not_logged_in 
when_i_apply_to_be_an_openstile_boutique
then_i_should_receive_confirmation_of_my_application
then_an_admin_should_be_notified_of_my_application
end

def when_i_apply_to_be_an_openstile_boutique
	click_link 'Apply'

	expect(page).to have_content('First Name')
	expect(page).to have_content('Last Name')
	#should form fields go here
end

def then_i_should_receive_confirmation_of_my_application
	click_link 'Submit'

end

def then_an_admin_should_be_notified_of_my_application
	#email notification language

end