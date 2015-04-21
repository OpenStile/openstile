desc "Heroku scheduler tasks"
task :email_drop_in_reminder => :environment do
  puts "Sending out email reminders for drop ins."
  DropIn.reminder
  puts "Emails sent!"
end
