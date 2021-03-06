shared_examples "a_well_tested_mailer" do
  let(:greeting) { "#{asserted_greeting}" }
  let(:full_subject) { "#{asserted_subject}" }
  let(:recipient) { "#{asserted_recipient}" }
  let(:mail_method) { asserted_mail_method }
  let(:body) { asserted_body }

  it "sets the correct subject" do
    expect(mail_method.subject).to eq(full_subject)
  end

  it "should be from info@openstile.com" do
    expect(mail_method.from).to include('info@openstile.com')
  end

  it "should be to the correct recipient" do
    expect(mail_method.to).to include(recipient)
  end

  it "includes body in the body of the email" do
    body.each do |content|
      expect(mail_method.body.encoded).to match(content)
    end
  end
end
