# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

['00 (XXS)', '0 (XS)', '2 (XS)', '4 (S)', '6 (S)', '8 (M)', '10 (M)',
 '12 (L)', '14 (L)', '16 (XL)', '18 (XL)', '20 (XXL)'].each do |size|
  TopSize.find_or_create_by(name: size)
  DressSize.find_or_create_by(name: size)
  BottomSize.find_or_create_by(name: size)
end

['Petite', 'Tall', 'Curvy', 'Full-figured', 'Slender', 'Athletic'].each do |build|
  BodyBuild.find_or_create_by(name: build)
end

['boho1', 'boho2', 'casual1', 'classic1', 'classic2',
 'diva2', 'preppy1', 'rocker1', 'rocker2'].each do |look|
  Look.find_or_create_by(name: look, image_path: "looks/#{look}.jpg")
end

["Arms", "Back", "Cleavage", "Legs", "Midsection"].each do |part|
  Part.find_or_create_by(name: part)
end

["Beiges", "Black", "Blues", "Browns", "Greens", "Oranges",
 "Pinks", "Purples", "Reds", "White", "Yellows", "Metallics"].each do |color|
  Color.find_or_create_by(name: color)
end

[{name: 'Straight', 
  description: 'Your bust and hips are basically the same size. Your waist is slightly smaller than your bust and hips.'},
 {name: 'Pear', 
  description: 'Your hips are larger than your bust, and your waist gradually slopes out to the hips.'},
 {name: 'Hourglass', 
  description: 'Your bust and hips are basically the same size and your waist is well defined.'},
 {name: 'Apple', 
  description: 'Your waist is larger than your bust and hips. Your hips are narrow compared to your shoulders.'},
 {name: 'Inverted Triangle', 
  description: 'Your bust is large, your hips are narrow and your waist is not very well defined.'}].each do |body_shape|
  BodyShape.find_or_create_by(name: body_shape[:name], description: body_shape[:description])
end

['Eco-friendly', 'Local designers', 'Ethically-made', 'Second-wear', 'Made in the USA'].each do |consideration|
  SpecialConsideration.find_or_create_by(name: consideration)
end

['Form-Fitting/Tight', 'Tailored/Fitted', 'Loose/Flowing', 'Oversized'].each do |fit|
  TopFit.find_or_create_by(name: fit)
end

['Form-Fitting/Tight', 'Tailored/Fitted', 'Loose/Flowing'].each do |fit|
  BottomFit.find_or_create_by(name: fit)
end

if ENV["demo_up"]
  location = Location.create!(address: '2439 18th Street, Brooklyn, NY 11213',
                              neighborhood: 'Adams Morgan')

  retailer = Retailer.create!(name: 'Violet Boutique',
                              description: 'This is a retailer created for OpenStile demo puposes. ' +
                                  'This retailer carries some of the best local designers in ' +
                                  'Washington DC. Tons of new items added every week so check ' +
                                  'back regularly!',
                              location: location,
                              size_range: '00 (XS) - 20 (XXL)',
                              price_index: 2,
                              status: 1)

  retailer.create_online_presence(web_link: 'http://google.com',
                                  facebook_link: 'http://facebook.com',
                                  twitter_link: 'http://twitter.com',
                                  instagram_link: 'http://instagram.com')

  retailer.drop_in_availabilities.create!(template_date: Date.current,
                                          start_time: "09:00:00",
                                          end_time: "17:00:00",
                                          frequency: "Daily",
                                          bandwidth: 2,
                                          location: location)


  location = Location.create!(address: '1387 Carroll St., Brooklyn, NY 11213',
                              neighborhood: 'Crown Heights')

  retailer = Retailer.create!(name: 'Jupe NYC',
                              description: 'This is a retailer created for OpenStile demo puposes. ' +
                                  'This retailer carries some of the best local designers in ' +
                                  'Washington DC. Tons of new items added every week so check ' +
                                  'back regularly!',
                              location: location,
                              size_range: '00 (XS) - 14 (XL)',
                              price_index: 1,
                              status: 1)

  retailer.create_online_presence(web_link: 'http://google.com',
                                  facebook_link: 'http://facebook.com',
                                  twitter_link: 'http://twitter.com',
                                  instagram_link: 'http://instagram.com')

  retailer.drop_in_availabilities.create!(template_date: Date.current,
                                          start_time: "09:00:00",
                                          end_time: "17:00:00",
                                          frequency: "Daily",
                                          bandwidth: 2,
                                          location: location)

end

if ENV["demo_down"]
  Retailer.destroy_all
end
