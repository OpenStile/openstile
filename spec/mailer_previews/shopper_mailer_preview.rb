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

  def after_styling_reminder
    ShopperMailer.after_styling_reminder(DropIn.where(status: DropIn::ACTIVE_STATE).first)
  end

  def invite_shopper_interest
    ShopperMailer.invite_shopper_interest('Jane', 'jane@example.com')
  end
end