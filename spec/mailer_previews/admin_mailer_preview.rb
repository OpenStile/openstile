class AdminMailerPreview < ActionMailer::Preview
  def referral_submitted
    AdminMailer.referral_submitted(referrer_name: 'Jane', referrer_email: 'jane@doe.com',
                                                        store_name: 'ABC Boutique', website: 'www.example.com',
                                                        contact_name: 'Ruth', contact_email: 'ruth@store.com')
  end

  def drop_in_scheduled
    AdminMailer.drop_in_scheduled(DropIn.first)
  end
end