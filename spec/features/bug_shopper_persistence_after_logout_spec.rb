require 'rails_helper'

feature 'Shopper persistence after logout' do
  scenario 'should maintain shopper top sizes' do

    @top = FactoryGirl.create(:top_size)

    given_i_am_a_logged_in_shopper
    and_i_add_a_top_size_to_my_style_profile
    when_i_log_out_and_log_back_in
    then_my_style_profile_should_contain_the_top
  end

  def given_i_am_a_logged_in_shopper
    @shopper = FactoryGirl.create(:shopper)
    capybara_sign_in @shopper
  end

  def and_i_add_a_top_size_to_my_style_profile
    click_link 'Style Profile'
    find("#style_profile_top_size_ids_#{@top.id}").set(true)
    click_button style_profile_save 
  end

  def when_i_log_out_and_log_back_in
    click_link 'Log out'
    capybara_sign_in @shopper
  end

  def then_my_style_profile_should_contain_the_top
    click_link 'Style Profile'
    expect(find("#style_profile_top_size_ids_#{@top.id}")).to be_checked
  end
end
