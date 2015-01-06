# require 'rails_helper'

# describe 'Shopper registration' do
#   let(:shopper_email) {'registration_test_shopper@example.com'}
#   let(:shopper_password) {'registration_test_password'}
#   it 'allows new shoppers to register with an email address and password' do
  
#     # sign up
#     visit '/shoppers/sign_up'
 
#     fill_in 'Email', with: shopper_email
#     fill_in 'Password', with: shopper_password
#     fill_in 'Confirm password', with: shopper_password
 
#     click_button 'Sign up'
 
#     page.should have_content("A message with a confirmation link has been sent to your email address. Please open the link to activate your account.")
 
#     # open the most recent email sent to shopper_email
#     # and capybara-email and email_spec gems are installed.
#     # assumes config/environments/test.rb has the line
#     #   config.action_mailer.delivery_method = :test
#     open_email(shopper_email)
 
#     # test that the email contains what we want
#     current_email.should deliver_to shopper_email
#     current_email.should have_body_text(/You can confirm your account/)
#     current_email.should have_body_text(/shoppers\/confirmation\?confirmation/)
#     current_email.should have_subject(/Confirmation instructions/)
 
#     # I'd really like something akin to current_email.click_link('Confirm my account') 
#     # but capybara-email doesn't seem to work for me
#     click_first_link_in_email
#     page.should have_content("Your account was successfully confirmed")
 
#     # check that the confirmation worked.
#     shopper = Shopper.find_for_authentication(email: shopper_email)
#     shopper.should be_confirmed
#   end
# end
