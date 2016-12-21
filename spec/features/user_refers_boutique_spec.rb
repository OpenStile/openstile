require 'rails_helper'

feature 'User refers a boutique' do
  before { ActionMailer::Base.deliveries = [] }

  scenario 'through the referral form', js: true, perform_enqueued: true do
    FactoryGirl.create(:admin_user, email: 'admin1@openstile.com')
    FactoryGirl.create(:admin_user, email: 'admin2@openstile.com')

    given_i_visit_the_boutique_page
    when_i_submit_an_invalid_referral
    then_i_should_be_instructed_to_resubmit
    when_i_submit_a_valid_referral 'jane@example.com', 'Chic Boutique'
    then_i_should_see_submission_successful
    then_i_should_receive_an_email_to_confirm 'jane@example.com', 'Chic Boutique'
    then_all_admins_should_receive_an_email_with_referral 'jane@example.com', 'Chic Boutique'
  end

  scenario 'when no admin present', js: true, perform_enqueued: true do
    given_i_visit_the_boutique_page
    when_i_submit_an_invalid_referral
    then_i_should_be_instructed_to_resubmit
    when_i_submit_a_valid_referral 'jane@example.com', 'Chic Boutique'
    then_i_should_see_submission_successful
    then_i_should_receive_an_email_to_confirm 'jane@example.com', 'Chic Boutique'
  end

  def given_i_visit_the_boutique_page
    visit '/retailers'
  end

  def when_i_submit_an_invalid_referral
    click_link 'Know a good boutique for OpenStile?'
    click_button 'Submit'
  end

  def then_i_should_be_instructed_to_resubmit
    expect(page).to have_content('Oops, there was an error saving the information')
    expect(page).to have_button('Submit', visible: true)
  end

  def when_i_submit_a_valid_referral referrer, boutique
    fill_in 'Your name', with: 'Jane'
    fill_in 'Your email', with: referrer
    fill_in 'Store name', with: boutique
    fill_in 'Link to store', with: 'www.boutique.com'
    fill_in 'Store contact name', with: 'Jenny'
    fill_in 'Store contact email', with: 'jenny@store.com'

    click_button 'Submit'
  end

  def then_i_should_see_submission_successful
    expect(page).to have_content('Thanks for your referral!')
    expect(page).to_not have_button('Submit', visible: true)
  end

  def then_i_should_receive_an_email_to_confirm referrer, boutique
    emails_to_referrer = ActionMailer::Base.deliveries.select{|email| email.to[0] == referrer}
    expect(emails_to_referrer.count).to eq(1)

    email = emails_to_referrer.first

    expect(email.subject).to eq('Thanks for the OpenStile referral!')

    [email.html_part.body.to_s, email.text_part.body.to_s].each do |body|
      expect(body).to include('Hi Jane')
      expect(body).to include("Thanks for recommending #{boutique}")
      expect(body).to include("We'll reach out to Jenny")
    end
  end

  def then_all_admins_should_receive_an_email_with_referral referrer, boutique
    emails_to_admins = ActionMailer::Base.deliveries.select{|email|
      email.to.count == 2  &&
          email.to.include?('admin1@openstile.com') &&
          email.to.include?('admin2@openstile.com')
    }
    expect(emails_to_admins.count).to eq(1)

    email = emails_to_admins.first

    expect(email.subject).to eq("OpenStile referral: #{boutique}")
    [email.html_part.body.to_s, email.text_part.body.to_s].each do |body|
      expect(body).to include("Jane - #{referrer}")
      expect(body).to include("#{boutique} - www.boutique.com")
      expect(body).to include("Jenny - jenny@store.com")
    end
  end
end