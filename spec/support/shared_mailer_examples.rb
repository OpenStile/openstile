shared_examples "a_well_tested_mailer" do
  let(:greeting) { "#{asserted_greeting}" }
  let(:full_subject) { "#{asserted_subject}" }
  let(:recipient) { "#{asserted_recipient}" }
  let(:mail_method) { asserted_mail_method }

  it "renders the headers" do
    expect(mail_method.content_type).to start_with('multipart/alternative') #html / text support
  end

  it "sets the correct subject" do
    expect(mail_method.subject).to eq(full_subject)
  end

  it "should be from 'no-reply@openstile.com'" do
    expect(mail_method.from).to include('no-reply@openstile.com')
  end

  it "should be to the correct recipient" do
    expect(mail_method.to).to include(recipient)
  end

  it "includes asserted_body in the body of the email" do
    asserted_body.each do |content|
      expect(mail_method.body.encoded).to match(content)
    end
  end
end
