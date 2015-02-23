class ChangeDropInAvailabilityDatetimeFormat < ActiveRecord::Migration
  def up
    existing_availabilities = []
    DropInAvailability.all.each do |availability|
      existing_availabilities << {id: availability.id, 
                                  date: availability.start_time.to_date}
    end

    add_column :drop_in_availabilities, :template_date, :date
    change_column :drop_in_availabilities, :start_time, :time
    change_column :drop_in_availabilities, :end_time, :time

    DropInAvailability.reset_column_information
    existing_availabilities.each do |hash|
      DropInAvailability.find(hash[:id]).update(template_date: hash[:date])
    end
  end

  def down
    remove_column :drop_in_availabilities, :template_date, :date
    remove_column :drop_in_availabilities, :start_time, :time
    remove_column :drop_in_availabilities, :end_time, :time
    add_column :drop_in_availabilities, :start_time, :datetime
    add_column :drop_in_availabilities, :end_time, :datetime
  end
end
