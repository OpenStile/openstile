def given_i_am_a_logged_in_user user
  if(page.has_link? 'Log out')
    click_link 'Log out'
  end
  capybara_sign_in user
end

def then_i_and_the_retail_user_should_receive_an_email shopper_email, retail_user_email
  count = ActionMailer::Base.deliveries.count
  last_two_receipients = ActionMailer::Base.deliveries[count-2, count-1]
                             .map(&:to).flatten
  expect(last_two_receipients).to include(retail_user_email)
  expect(last_two_receipients).to include(shopper_email)
end
