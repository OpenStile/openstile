class AddReminderEmailSentBitToDropIns < ActiveRecord::Migration
  def change
    add_column :drop_ins, :reminder_email_sent, :boolean, :default => false, :null => true

    DropIn.reset_column_information
  end
end
