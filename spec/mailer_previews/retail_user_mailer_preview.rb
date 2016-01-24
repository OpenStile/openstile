class RetailUserMailerPreview < ActionMailer::Preview
  def drop_in_scheduled_email
    RetailUserMailer.drop_in_scheduled_email(DropIn.first)
  end

  def drop_in_canceled_email
    RetailUserMailer.drop_in_canceled_email(DropIn.first)
  end
end