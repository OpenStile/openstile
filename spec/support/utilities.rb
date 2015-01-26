
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
  DateTime.current.at_beginning_of_day.advance(days: 1)
end

def tomorrow_mid_morning
  DateTime.current.at_beginning_of_day.advance(days: 1, hours: 1)
end

def tomorrow_afternoon
  DateTime.current.at_midday.advance(days: 1)
end

def tomorrow_evening
  DateTime.current.at_midday.advance(days: 1, hours: 2)
end
