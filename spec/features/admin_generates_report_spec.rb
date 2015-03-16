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

  private
    def create_new_shoppers count, datetime
      count.times{FactoryGirl.create(:shopper, created_at: datetime)}
    end
end
