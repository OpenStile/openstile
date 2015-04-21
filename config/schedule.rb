# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

job_type :verbose_rake,    "cd :path && :environment_variable=:environment bundle exec rake :task"

every  10.minutes do
  verbose_rake "email_drop_in_reminder"
end
