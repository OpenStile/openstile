require 'rails_helper'

 feature 'Retailer interest' do
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
	fill_in "First name", with: "Jane"
	fill_in "Last name", with: "Doe"
	fill_in "Boutique name", with: "Bad Boutique"
	fill_in "Website address", with: "www.badboutique.com"
	fill_in "Street address", with: ""
	fill_in "City", with: "Brooklyn"
	fill_in "State", with: "NY"
	fill_in "Zip/Postal Code", with: ""
	fill_in "Email", with: "badboutique@boutique.com"
	fill_in "Phone Number", with: "240-888-3239"
	fill_in "Describe your store aesthetic", with: "500 words or less"
	click_link "Submit"
 end

 def then_i_should_receive_confirmation_of_my_application

 end

 def then_an_admin_should_be_notified_of_my_application
	#email notification language
 end
end