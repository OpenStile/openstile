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

["Bohemian_Chic_Hipster", "Preppy", "Casual_Relaxed", 
 "Classic_Vintage", "Edgy_Rocker", "Glamorous_Diva"].each do |look|
  Look.find_or_create_by(name: look)
end

["Arms", "Back", "Cleavage", "Legs", "Midsection"].each do |part|
  Part.find_or_create_by(name: part)
end

["Beige", "Black", "Blue", "Brown", "Green", 
 "Gray", "Navy", "Orange", "Pink", "Purple", 
 "Red", "Teal", "White", "Yellow", "Gold", "Silver"].each do |color|
  Color.find_or_create_by(name: color)
end

["Bold Patterns", "Bright Colors", "Florals", "Animal Prints",
 "Leather", "Faux Leather", "Fur", "Faux Fur"].each do |print|
  Print.find_or_create_by(name: print)
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

['Eco-friendly', 'Local designers', 'Ethically-made', 'Second-wear'].each do |consideration|
  SpecialConsideration.find_or_create_by(name: consideration)
end

['Form-Fitting/Tight', 'Tailored/Fitted', 'Loose/Flowing', 'Oversized'].each do |fit|
  TopFit.find_or_create_by(name: fit)
end

['Form-Fitting/Tight', 'Tailored/Fitted', 'Loose/Flowing'].each do |fit|
  BottomFit.find_or_create_by(name: fit)
end

if ENV["demo_up"]
  (1..5).each do |idx|
    location = Location.create!(address: "#{Faker::Address.street_address}, Washington, DC",
                                neighborhood: ['15th & U', 'Petworth', 'Capitol Hill', 
                                               'Dupont Circle', 'Columbia Heights'].sample)

    retailer = Retailer.create!(name: "#{Faker::Address.street_name} Boutique",
                               description: 'This is a retailer created for OpenStile demo puposes. ' +
                                            'This retailer carries some of the best local designers in ' +
                                            'Washington DC. Tons of new items added every week so check ' +
                                            'back regularly!',
                               location: location,
                               look_id: Look.ids.sample,
                               body_shape_id: BodyShape.ids.sample,
                               top_fit_id: TopFit.ids.sample,
                               bottom_fit_id: BottomFit.ids.sample, 
                               special_consideration_ids: SpecialConsideration.ids.sample(2),
                               status: 1)

    retailer.create_price_range(top_min_price: 0, top_max_price: 500, 
                                bottom_min_price: 0, bottom_max_price: 500,
                                dress_min_price: 0, dress_max_price: 500) 

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

    retailer.top_sizes << TopSize.all                                 
    retailer.bottom_sizes << BottomSize.all                                 
    retailer.dress_sizes << DressSize.all                                 

    top = retailer.tops.create!(name: "#{Faker::Name.name} Designs Blouse",
                                description: 'This is a blouse created for OpenStile demo purposes.',
                                price: (30..70).to_a.sample,
                                web_link: 'http://example.com',
                                look_id: Look.ids.sample,
                                print_id: Print.ids.sample,
                                color_id: Color.ids.sample,
                                body_shape_id: BodyShape.ids.sample,
                                for_petite: idx.even?,
                                top_fit_id: TopFit.ids.sample,
                                special_consideration_ids: [SpecialConsideration.ids.sample],
                                status: 1)
    top.top_sizes << TopSize.all
    top.exposed_parts.create(part_id: Part.find_by_name(['Midsection','Arms','Back','Cleavage'].sample))

    bottom = retailer.bottoms.create!(name: "#{Faker::Name.name} Designs Pants",
                                      description: 'This is a pair of pants created for OpenStile demo purposes.',
                                      price: (50..150).to_a.sample,
                                      web_link: 'http://example.com',
                                      look_id: Look.ids.sample,
                                      print_id: Print.ids.sample,
                                      color_id: Color.ids.sample,
                                      body_shape_id: BodyShape.ids.sample,
                                      for_petite: idx.even?,
                                      bottom_fit_id: BottomFit.ids.sample, 
                                      special_consideration_ids: [SpecialConsideration.ids.sample],
                                      status: 1)
    bottom.bottom_sizes << BottomSize.all

    dress = retailer.dresses.create!(name: "#{Faker::Name.name} Designs Dress",
                                     description: 'This is a dress created for OpenStile demo purposes.',
                                     price: (75..200).to_a.sample,
                                     web_link: 'http://example.com',
                                     look_id: Look.ids.sample,
                                     print_id: Print.ids.sample,
                                     color_id: Color.ids.sample,
                                     body_shape_id: BodyShape.ids.sample,
                                     for_petite: idx.even?,
                                     top_fit_id: TopFit.ids.sample,
                                     bottom_fit_id: BottomFit.ids.sample, 
                                     special_consideration_ids: [SpecialConsideration.ids.sample],
                                     status: 1)
    dress.dress_sizes << DressSize.all

  end
end

if ENV["demo_down"]
  Retailer.destroy_all
end
