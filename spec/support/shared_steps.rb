def given_i_am_a_logged_in_user user
  if(page.has_link? 'Log out')
    click_link 'Log out'
  end
  capybara_sign_in user
end


