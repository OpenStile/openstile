desc "Heroku scheduler tasks"
task :email_drop_in_reminder => :environment do
  DropIn.reminder
end
