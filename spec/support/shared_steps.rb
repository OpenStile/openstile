def given_i_am_a_logged_in_user user
  if(page.has_link? 'Log out')
    click_link 'Log out'
  end
  capybara_sign_in user
end

def seed_style_profile_options
  ['2 (XS)', '4 (S)', '6 (S)'].each{|s| FactoryGirl.create(:top_size, name: s)}
  ['6 (S)', '8 (M)', '10 (M)'].each{|s| FactoryGirl.create(:dress_size, name: s)}
  ['6 (S)', '8 (M)', '10 (M)'].each{|s| FactoryGirl.create(:bottom_size, name: s)}

  ['Petite', 'Curvy', 'Tall'].each{|b| FactoryGirl.create(:body_build, name: b)}

  ['Hipster1', 'Girly2', 'Rocker3'].each{|l| FactoryGirl.create(:look, name: l)}

  ['Made in USA', 'Ethically-made', 'Eco-friendly'].each{|sc|
    FactoryGirl.create(:special_consideration, name: sc) }

  ['Loose', 'Oversized'].each{|f| FactoryGirl.create(:top_fit, name: f)}
  ['Tight', 'Flowing'].each{|f| FactoryGirl.create(:bottom_fit, name: f)}

  ['Arms', 'Legs', 'Midsection', 'Cleavage'].each{|p| FactoryGirl.create(:part, name: p)}

  ['Hourglass', 'Apple', 'Straight'].each{|s| FactoryGirl.create(:body_shape, name: s, description: 'A description')}

  ['Beiges', 'Pinks', 'Blues'].each{|c| FactoryGirl.create(:color, name: c)}
end
