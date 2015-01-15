def given_i_am_a_logged_in_shopper shopper
  capybara_sign_in shopper
end

def when_i_set_my_style_profile_sizes_to sizes
  click_link 'Style Profile'

  within(:css, "div#top_sizes") do
    check(sizes[:top_size].name)
  end
  within(:css, "div#bottom_sizes") do
    check(sizes[:bottom_size].name)
  end
  within(:css, "div#dress_sizes") do
    check(sizes[:dress_size].name)
  end
  click_button style_profile_save 

  expect(page).to have_content('My Style Feed')
end

def when_i_set_my_style_profile_budget_to budget
  click_link 'Style Profile'

  within(:css, "div#budgets") do
    select(budget[:dress], from: "A dress:")
    select(budget[:top], from: "A top or blouse:")
    select(budget[:bottom], from: "A pair of pants or jeans:")
  end

  click_button style_profile_save 

  expect(page).to have_content('My Style Feed')
end

def then_my_style_feed_should_not_contain recommendation
  visit '/'
  expect(page).to_not have_content(recommendation.name)
end

def then_my_style_feed_should_contain recommendation
  visit '/'
  expect(page).to have_content(recommendation.name)
end
