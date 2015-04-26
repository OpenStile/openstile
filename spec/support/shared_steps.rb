require 'rake'

load File.expand_path("../../../lib/tasks/scheduler.rake", __FILE__)

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

def given_i_have_no_drop_ins_scheduled
  click_link 'Scheduled Drop-ins'

  expect(page)
    .to have_content("regular ole' shopping trip into a fun indulgence")
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

def when_i_set_my_style_profile_feelings_for_a_look_as look, partiality
  click_link 'Style Profile'

  within(:css, "div#look_#{look.id}") do
    if partiality == :hate
      select "I hate it!", from: 'Tolerance'
    end
    if partiality == :impartial
      select "It's alright", from: 'Tolerance'
    end
    if partiality == :love
      select "I love it!", from: 'Tolerance'
    end
  end

  click_button style_profile_save

  expect(page).to have_content('My Style Feed')
end

def when_i_set_my_style_profile_avoided_colors color, action
  click_link 'Style Profile'

  within(:css, "div.avoided-colors") do
    if action == :check
      check(color.name)
    elsif action == :uncheck
      uncheck(color.name)
    end
  end

  click_button style_profile_save 

  expect(page).to have_content('My Style Feed')
end

def when_i_view_featured_items_in_style_feed refresh=true
  visit '/' if refresh

  click_link 'Featured items'
  expect(page).to have_content('a sampling of what our retailers carry')
  expect(page).to_not have_content('our retailers committed to offering')
  expect(page).to_not have_content("you've marked as favorites")
end

def when_i_view_retailers_in_style_feed refresh=true
  visit '/' if refresh

  click_link 'Our retailers'
  expect(page).to have_content('our retailers committed to offering')
  expect(page).to_not have_content('a sampling of what our retailers carry')
  expect(page).to_not have_content("you've marked as favorites")
end

def when_i_view_favorites_in_style_feed refresh=true
  visit '/' if refresh

  click_link 'My favorites'
  expect(page).to have_content("you've marked as favorites")
  expect(page).to_not have_content('our retailers committed to offering')
  expect(page).to_not have_content('a sampling of what our retailers carry')
end

def then_the_feed_should_contain recommendation
  status = page.has_selector?('h3', text: recommendation.summary, visible: true)
  expect(status).to be(true)
end

def then_the_feed_should_not_contain recommendation
  status = page.has_selector?('h3', text: recommendation.summary, visible: true)
  expect(status).to be(false)
end

def when_i_set_my_style_profile_body_shape_to body_shape
  click_link 'Style Profile'

  within(:css, "div.body-shape") do
    choose("style_profile_body_shape_id_#{body_shape.id}")
  end

  click_button style_profile_save
  expect(page).to have_content('My Style Feed')
end

def when_i_set_my_style_profile_height_to height
  click_link 'Style Profile'

  feet = height.first if height.match(/^\d\sfeet/)

  within(:css, "div.height") do
    select feet, from: 'feet'
    select "0", from: 'inches'
  end

  click_button style_profile_save
  expect(page).to have_content('My Style Feed')
end

def when_i_set_my_style_profile_body_build_to build
  click_link 'Style Profile'

  within(:css, "div.body-build") do
    select build, from: 'Build'
  end

  click_button style_profile_save
  expect(page).to have_content('My Style Feed')
end

def when_i_set_my_style_profile_preferred_fit_as fit, type
  click_link 'Style Profile'

  within(:css, "div.fit") do
    if type == :top
      select fit, from: 'Top fit'
    end
    if type == :bottom
      select fit, from: 'Bottom fit'
    end
  end

  click_button style_profile_save
  expect(page).to have_content('My Style Feed')
end

def when_i_set_my_style_profile_feelings_for_a_consideration_as consideration, importance
  click_link 'Style Profile'

  within(:css, "div.considerations") do
    if importance == :important
      check(consideration.name)
    end
    if importance == :not_important
      uncheck(consideration.name)
    end
  end

  click_button style_profile_save
  expect(page).to have_content('My Style Feed')
end

def when_i_set_my_style_profile_coverage_preference_as parts, tolerance
  click_link 'Style Profile'

  parts.each do |part|
    within(:css, "div#part_#{part.id}") do
      if tolerance == :cover
        choose "Cover"
      end
      if tolerance == :impartial
        choose "Mix it up"
      end
      if tolerance == :flaunt
        choose "Show off"
      end
    end
  end

  click_button style_profile_save

  expect(page).to have_content('My Style Feed')
end

def when_i_set_my_style_profile_feelings_for_a_print_as print, partiality
  click_link 'Style Profile'

  within(:css, "div#print_#{print.id}") do
    if partiality == :hate
      choose "Hate"
    end
    if partiality == :impartial
      choose "Impartial"
    end
    if partiality == :love
      choose "Love"
    end
  end

  click_button style_profile_save

  expect(page).to have_content('My Style Feed')
end

def then_the_recommendation_ordering_should_be higher_ranking, lower_ranking, refresh=true
  visit '/' if refresh
  expect(page.body.index(higher_ranking.summary)).to be < (page.body.index(lower_ranking.summary))
end

def then_the_recommendation_should_be_for recommendation_string
  visit '/'
  expect(page).to have_content("Recommended for #{recommendation_string}")
end

def given_my_upcoming_drop_ins_page_contains appointment
  click_link 'Scheduled Drop-ins'

  expect(page).to have_content(appointment.retailer.name)
  expect(page).to have_content(appointment.colloquial_time)
end

def when_i_select_a_recommendation recommendation
  visit '/'

  tab = recommendation.is_a?(Retailer) ? 'retailers' : 'featured'

  within(:css, "div##{tab}_#{recommendation.class.to_s.downcase.pluralize}_#{recommendation.id}") do
    first(:link).click
  end

  expect(page).to have_content(recommendation.description)
end

def then_i_and_the_retail_user_should_receive_an_email retail_user_email, shopper_email
  count = ActionMailer::Base.deliveries.count
  last_two_receipients = ActionMailer::Base.deliveries[count-2, count-1]
                                                  .map(&:to).flatten
  expect(last_two_receipients).to include(retail_user_email)
  expect(last_two_receipients).to include(shopper_email)
end

def given_the_scheduler_has_run_the_drop_in_reminder_job
  Rake::Task.define_task(:environment)
  Rake::Task['email_drop_in_reminder'].invoke
end

def then_i_and_the_retail_user_should_receive_a_reminder_email retail_user_email, shopper_email, drop_in
  then_i_and_the_retail_user_should_receive_an_email retail_user_email, shopper_email
  expect(drop_in.reminder_email_sent).to be true
end

def then_the_email_should_have_an_ics_attachment
  last_two_emails = ActionMailer::Base.deliveries.reverse[0..1]
  last_two_emails.each do |mail|
    attachment = mail.attachments[0]
    expect(attachment).to_not be nil
    expect(attachment).to be_a_kind_of(Mail::Part)
    expect(attachment.content_type).to start_with('text/calendar;')
    expect(attachment.filename).to eq('event.ics')
  end
end
