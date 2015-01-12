
def capybara_sign_in shopper
  visit '/'
  click_link 'Log in'
  fill_in 'Email', with: shopper.email
  fill_in 'Password', with: shopper.password
  click_button 'Log in'
end

def style_profile_save
  'Save and continue to Style Feed'
end
