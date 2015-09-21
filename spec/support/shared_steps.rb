def given_i_am_a_logged_in_shopper shopper
  if(page.has_link? 'Log out')
    click_link 'Log out'
  end
  capybara_sign_in shopper
end

def given_i_am_a_logged_in_admin admin_user
  if(page.has_link? 'Log out')
    click_link 'Log out'
  end
  visit '/admins/sign_in'
  fill_in 'Email', with: admin_user.email
  fill_in 'Password', with: admin_user.password
  click_button 'Log in'
end

def given_i_am_a_logged_in_retail_user retail_user
  if(page.has_link? 'Log out')
    click_link 'Log out'
  end
  visit '/'
  click_link 'Log in'
  click_link 'Switch to retailer log in'
  fill_in 'Email', with: retail_user.email
  fill_in 'Password', with: retail_user.password
  click_button 'Log in'
end

def then_i_and_the_retail_user_should_receive_an_email shopper_email, retail_user_email
  count = ActionMailer::Base.deliveries.count
  last_two_receipients = ActionMailer::Base.deliveries[count-2, count-1]
                             .map(&:to).flatten
  expect(last_two_receipients).to include(retail_user_email)
  expect(last_two_receipients).to include(shopper_email)
end
