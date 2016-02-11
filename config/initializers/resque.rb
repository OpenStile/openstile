#config/initializers/resque.rb

Resque.redis = Redis.new
Resque.after_fork = Proc.new { ActiveRecord::Base.establish_connection }