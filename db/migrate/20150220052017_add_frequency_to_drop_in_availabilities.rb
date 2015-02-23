class AddFrequencyToDropInAvailabilities < ActiveRecord::Migration
  def change
    add_column :drop_in_availabilities, :frequency, :string

    DropInAvailability.reset_column_information
    DropInAvailability.update_all(frequency: "One-time")
  end
end
