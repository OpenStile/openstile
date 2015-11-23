require 'rails_helper'

feature 'Customer reviews drop in' do
  let(:shopper){ FactoryGirl.create(:shopper_user) }
  let(:retailer){ FactoryGirl.create(:retailer) }
  let(:retail_user){ FactoryGirl.create(:retailer_user,
                                         retailer: retailer) }
  let!(:drop_in_availability){ FactoryGirl.create(:drop_in_availability,
                                                 template_date: 1.day.ago,
                                                 start_time: '09:00:00',
                                                 end_time: '17:00:00',
                                                 retailer: retailer) }
  let!(:drop_in){ FactoryGirl.create(:drop_in,
                                      retailer: retailer,
                                      user: shopper,
                                      time: 1.day.ago.change(hour: 12)) }

  scenario 'on shopper side' do
    given_i_am_a_logged_in_user shopper
    when_i_navigate_to_my_drop_ins_as_shopper
    when_i_review_drop_in_as_shopper drop_in, '4 out of 5', 
                     "It was great! Love shopping this way"
    then_i_should_see_drop_in_successfully_reviewed drop_in, 4
  end
                                      
  scenario 'on retailer side' do
    given_i_am_a_logged_in_user retail_user
    when_i_navigate_to_my_drop_ins_as_retailer
    when_i_review_drop_in_as_retailer drop_in, '5 out of 5', 
                     "Awesome! Loved meeting the new customer", '56.00'
    then_i_should_see_drop_in_successfully_reviewed drop_in, 5
  end

  def when_i_navigate_to_my_drop_ins_as_shopper
    click_link 'logo-home'
  end

  def when_i_navigate_to_my_drop_ins_as_retailer
    click_link 'My appointments'
  end

  def when_i_review_drop_in_as_shopper past_drop_in, rating, feedback
    within(:css, "div#drop_in_#{past_drop_in.id}") do
      click_link '[edit]'
      select rating, from: 'Rating'
      fill_in 'Feedback', with: feedback
      click_button 'Save'
    end
  end

  def when_i_review_drop_in_as_retailer past_drop_in, rating, feedback, sales_amount
    within(:css, "div#drop_in_#{past_drop_in.id}") do
      click_link '[edit]'
      select rating, from: 'Rating'
      fill_in 'Feedback', with: feedback
      fill_in 'How much did the shopper spend?', with: sales_amount
      click_button 'Save'
    end
  end

  def then_i_should_see_drop_in_successfully_reviewed past_drop_in, rating
    within(:css, "div#drop_in_#{past_drop_in.id}") do
      expect(page).to have_css(".fa-star-selected", count: rating)
    end
  end
end
