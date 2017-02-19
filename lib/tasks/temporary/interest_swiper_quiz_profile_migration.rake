namespace :interest_swiper_quiz_profile do
  desc "Create profiles and migrate data from existing sessions"
  task migrate_sessions: :environment do
    existing_sessions = InterestSwiperQuiz::Session.all

    puts "Going to migrate #{existing_sessions.count} sessions"

    ActiveRecord::Base.transaction do
      existing_sessions.each do |session|
        profile = InterestSwiperQuiz::Profile.create!(first_name: session.first_name, last_name: session.last_name, email: session.email, created_at: session.created_at)
        session.profile_id = profile.id
        session.save!
        print "."
      end

      sessions_with_likes_ids = InterestSwiperQuiz::Like.all.pluck(:session_id).uniq
      active_sessions = InterestSwiperQuiz::Session.where("completed = 'true' OR id in (?)", sessions_with_likes_ids)
      bad_sessions = InterestSwiperQuiz::Session.where.not(id: active_sessions.pluck(:id))

      puts "Going to cleanup #{bad_sessions.count} bad sessions"

      bad_sessions.destroy_all
    end

    puts " All done now!"
  end
end