# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

["XS", "Small", "Medium", "Large", "XL"].each do |size|
  TopSize.find_or_create_by(name: size, category: "alpha")
  BottomSize.find_or_create_by(name: size, category: "alpha")
  DressSize.find_or_create_by(name: size, category: "alpha")
end

["00", "0", "2", "4", "6", "8", "10", "12", "14", "16", "18"].each do |size|
  TopSize.find_or_create_by(name: size, category: "numeric")
  BottomSize.find_or_create_by(name: size, category: "numeric")
  DressSize.find_or_create_by(name: size, category: "numeric")
end

("24".."34").each do |size|
  BottomSize.find_or_create_by(name: size, category: "inches")
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
  if Shopper.find_by_email('demo@example.com').nil?
    Shopper.create(first_name: 'Jane', email: 'demo@example.com',
                   password: 'openstile', password_confirmation: 'openstile')
  end

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
                               top_fit: ['Tight/Form-Fitting', 'Loose', 'Straight', 'Oversized'].sample,
                               bottom_fit: ['Tight/Skinny', 'Straight', 'Loose/Flowy'].sample, 
                               special_consideration_ids: SpecialConsideration.ids.sample(2))

    retailer.price_range.update!(top_min_price: 0, top_max_price: 500, 
                                 bottom_min_price: 0, bottom_max_price: 500,
                                 dress_min_price: 0, dress_max_price: 500) 

    retailer.create_online_presence(web_link: 'http://google.com',
                                    facebook_link: 'http://facebook.com',
                                    twitter_link: 'http://twitter.com',
                                    instagram_link: 'http://instagram.com')

    ["2015-01-29", "2015-01-30", "2015-01-31", "2015-02-01", "2015-02-02",
     "2015-02-04", "2015-02-05", "2015-02-07", "2015-02-08", "2015-02-09"].each do |date|
      
      retailer.drop_in_availabilities.create!(start_time: "#{date} 09:00:00 -0500",
                                              end_time: "#{date} 17:00:00 -0500",
                                              location: location,
                                              bandwidth: 2)
    end

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
                                top_fit: ['Tight/Form-Fitting', 'Loose', 'Straight', 'Oversized'].sample,
                                special_consideration_ids: [SpecialConsideration.ids.sample])
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
                                      bottom_fit: ['Tight/Skinny', 'Straight', 'Loose/Flowy'].sample, 
                                      special_consideration_ids: [SpecialConsideration.ids.sample])
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
                                     top_fit: ['Tight/Form-Fitting', 'Loose', 'Straight', 'Oversized'].sample,
                                     bottom_fit: ['Tight/Skinny', 'Straight', 'Loose/Flowy'].sample, 
                                     special_consideration_ids: [SpecialConsideration.ids.sample])
    dress.dress_sizes << DressSize.all

  end
end

if ENV["demo_down"]
  demo_user = Shopper.find_by_email('demo@example.com')
  unless demo_user.nil?
    demo_user.destroy
  end

  Retailer.destroy_all
end
