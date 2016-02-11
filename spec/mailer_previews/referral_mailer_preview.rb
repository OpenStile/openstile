class ReferralMailerPreview < ActionMailer::Preview
  def referral_submitted
    ReferralMailer.referral_submitted(referrer_name: 'Jane', referrer_email: 'jane@doe.com',
                                                        store_name: 'ABC Boutique', website: 'www.example.com',
                                                        contact_name: 'Ruth', contact_email: 'ruth@store.com')
  end
end