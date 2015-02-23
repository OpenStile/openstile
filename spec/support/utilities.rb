
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

def tomorrow_morning
  DateTime.current.advance(days: 1).change(hour: 9)
end

def tomorrow_mid_morning
  DateTime.current.advance(days: 1).change(hour: 10)
end

def tomorrow_afternoon
  DateTime.current.advance(days: 1).change(hour: 13)
end

def tomorrow_evening
  DateTime.current.advance(days: 1).change(hour: 17)
end
