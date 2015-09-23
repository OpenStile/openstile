require 'rails_helper'

 feature 'Retailer interest form' do
 let!(:admin){ FactoryGirl.create(:admin)}

 scenario 'form submision details' do
 given_i_am_not_logged_in 
 when_i_apply_to_be_an_openstile_boutique
 then_i_should_receive_confirmation_of_my_application
 then_an_admin_should_be_notified_of_my_application
 end

 def given_i_am_not_logged_in
	visit "/"
 end

  def when_i_apply_to_be_an_openstile_boutique
	click_link "Apply Here"
	fill_in "First Name", with: "Jane"
	fill_in "Last Name", with: "Doe"
	click_link "Submit"
 end

 def then_i_should_receive_confirmation_of_my_application

 end

 def then_an_admin_should_be_notified_of_my_application
	#email notification language
 end
end