class ShopperMailerPreview < ActionMailer::Preview
  def drop_in_scheduled_email
    ShopperMailer.drop_in_scheduled_email(DropIn.first)
  end

  def drop_in_canceled_email
    ShopperMailer.drop_in_canceled_email(DropIn.first)
  end

  def upcoming_styling_reminder
    ShopperMailer.upcoming_styling_reminder(DropIn.where(status: DropIn::ACTIVE_STATE).first)
  end
end