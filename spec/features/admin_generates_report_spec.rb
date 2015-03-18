require 'rails_helper'

feature 'Admin user generates OpenStile report' do
  let(:admin){ FactoryGirl.create(:admin) }

  scenario 'with activation stats' do
    create_new_shoppers 5, 3.days.ago
    create_new_shoppers 10, 2.days.ago
    create_new_shoppers 15, 1.day.ago

    given_i_am_a_logged_in_admin admin
    when_i_generate_a_report 2.days.ago.strftime("%Y-%m-%d"), 
                             1.day.ago.strftime("%Y-%m-%d")
    then_it_should_have_an_activation_count_of 25
  end

  scenario 'with retention stats' do
    out_of_range_shoppers = create_new_shoppers(1, 10.days.ago, true) 
    in_range_shoppers = create_new_shoppers(3, 5.days.ago, true) 

    given_shopper_logs_in out_of_range_shoppers[0]
    given_shopper_logs_in in_range_shoppers[0]
    given_shopper_logs_in in_range_shoppers[0]
    given_shopper_logs_in in_range_shoppers[1]
    given_i_am_a_logged_in_admin admin
    when_i_generate_a_report 7.days.ago.strftime("%Y-%m-%d"), 
                             Date.current.to_s
    then_it_should_have_a_retention_count_of 2
  end

  scenario 'with revenue stats' do
    out_of_range_shoppers = create_new_shoppers(1, 10.days.ago) 
    in_range_shoppers = create_new_shoppers(3, 5.days.ago) 

    book_drop_ins_for_shoppers(out_of_range_shoppers + in_range_shoppers)
    in_range_shoppers[1].drop_ins.first.update(created_at: 1.day.from_now)

    given_i_am_a_logged_in_admin admin
    when_i_generate_a_report 7.days.ago.strftime("%Y-%m-%d"), 
                             Date.current.to_s
    then_it_should_have_a_revenue_count_of 2
  end

  def given_shopper_logs_in shopper
    visit '/'
    if page.has_link?('Log out')
      click_link 'Log out'
    end
    capybara_sign_in shopper
  end

  def when_i_generate_a_report start_report, end_report
    visit '/'
    click_link 'Generate report'
    fill_in 'Start', with: start_report
    fill_in 'End', with: end_report
    click_button 'Generate'
  end

  def then_it_should_have_an_activation_count_of count
    expect(page).to have_content("\"Activation\":#{count}")
  end

  def then_it_should_have_a_retention_count_of count
    expect(page).to have_content("\"Retention\":#{count}")
  end

  def then_it_should_have_a_revenue_count_of count
    expect(page).to have_content("\"Revenue\":#{count}")
  end

  private
    def create_new_shoppers count, datetime, via_capybara=false
      ret = []
      unless via_capybara
        count.times{ ret << FactoryGirl.create(:shopper, created_at: datetime)}
      else
        count.times do
          email = Faker::Internet.email
          visit '/'
          click_link 'Sign up'
          fill_in 'First name', with: Faker::Name.first_name
          fill_in 'Email address', with: email 
          fill_in 'Password', with: 'foobar' 
          fill_in 'Confirm password', with: 'foobar' 
          click_button 'Sign up'

          click_link 'Log out'

          last_added = Shopper.find_by_email(email)
          last_added.update!(created_at: datetime, 
                             password: 'foobar', 
                             password_confirmation: 'foobar')
          ret << last_added
        end
      end
      ret
    end

    def book_drop_ins_for_shoppers shoppers
      retailer = FactoryGirl.create(:retailer)
      FactoryGirl.create(:standard_availability_for_tomorrow, 
                          retailer: retailer,
                          bandwidth: 5)

      shoppers.each do |shopper|
        FactoryGirl.create(:drop_in, time: tomorrow_noon, 
                            shopper: shopper, retailer: retailer)
      end
    end
end
