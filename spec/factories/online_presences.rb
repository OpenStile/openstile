# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :online_presence do
    retailer nil
    web_link "www.example.com"
    facebook_link "www.facebook.com/example"
    twitter_link "www.twitter.com/example"
    instagram_link "www.instagram.com/example"
  end
end
