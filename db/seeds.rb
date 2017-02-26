# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

UserRole.find_or_create_by(name: UserRole::SHOPPER)
UserRole.find_or_create_by(name: UserRole::RETAILER)
UserRole.find_or_create_by(name: UserRole::ADMIN)

['00 (XXS)', '0 (XS)', '2 (XS)', '4 (S)', '6 (S)', '8 (M)', '10 (M)',
 '12 (L)', '14 (L)', '16 (XL)', '18 (XL)', '20 (XXL)'].each do |size|
  TopSize.find_or_create_by(name: size)
  DressSize.find_or_create_by(name: size)
  BottomSize.find_or_create_by(name: size)
end

['Petite', 'Tall', 'Curvy', 'Full-figured', 'Slender', 'Athletic'].each do |build|
  BodyBuild.find_or_create_by(name: build)
end

['boho1', 'boho2', 'casual1', 'classic1',
 'diva2', 'preppy1', 'rocker1', 'rocker2', 'classic2'].each do |look|
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

[["Janelle Working her Swag", "janelle"], ["Customizing Fendi's", "fendis"], ["Jamma me Beautiful", "jamma"],
["The Nerve to Curve", "curve"], ["The Nude Boot", "nude_boot"], ["Thigh Highs", "thigh_highs"], ["Neon Living", "neon"],
["The Last Unicorn", "unicorn"], ["Kitten Syndrome", "kitten"], ["This ain't no Granny", "granny"],
["Haute Vintage News", "haute_vintage"], ["Rocking a Work Day", "workday"], ["Riding into Fall", "riding_fall"],
["Rivera of Style", "rivera"], ["Bo Stays Warm", "bo_warm"], ["Style Flowing", "flowing"], ["Nature's Freedom", "freedom"],
["Rebel Rebel", "rebel"], ["Tough act to Follow", "tough_act"], ["Dr Martin's Style Prognosis", "dr_martin"],
["Modern Power", "modern_power"], ["Gray to brighten the day", "gray_day"], ["Monochromatic City Athlete", "city_athlete"],
["Power of Black", "power_black"], ["The Strength of Three", "three"]].each do |swiper_styles|
  InterestSwiperQuiz::Style.find_or_create_by(title: swiper_styles[0], image: swiper_styles[1])
end

red_carpet_quiz = ShareQuiz.find_or_create_by(name: 'red_carpet_quiz', description: "What's your red carpet style? Take this quiz to find out which stunning starlet captures your ultimate look!")
{"Blake Lively"       => ['blake', "You are a woman of drama. When you walk into the room everyone is gasping for air as you take their breathe away. You are a classic beauty who shows off your curves and make sure there is enough volume or drape in the gown to really cause a scene. You are no traditionalist though, you always love a unique modern detail to also be très chic. Have the people grasp their pearls, you are a vision to be seen."],
 "Janelle Monae"      => ['janelle', "Fearless, Feminine, and Fresh. You would think black and white were traditional colors, but not the when you put it together. You maybe loud but you never lose your elegance. You dance around line of avant garde with traditional ever so gracefully. We envy your confidence in your style. You could not be more feirce and could not worship you more for it."],
 "Nicole Kidman"      => ['nicole', "Romance. That is your heart and soul. No one is quite the romantic feminine beauty that you are. The whimiscal soul makes us swell with enchantment. You make us believe in love and we have an affair with your style. Come what may because there's no one as stunning as you."],
 "Kerry Washington"   => ['kerry', "You are nothing but class. Feminine and sophistiated. you are a sucker for floral details, but more than ever you are ever poised in your style. If only we could float down with elegance and grace on the carpet with your refined style."],
 "Jennifer Lopez"     => ['jlo', "You shine like a diamond. The ultimate diva of glamour. You are hardly ever seen without body shimmering with gems and stones, but that's just the icing on the cake. You are the definition of sexy. You are body confident and you should be as you got curves for miles. You are worshipped on the red carpet as we are blinded by your racy and glitzy, glamour."],
 "Emma Stone"         => ['emma', "Old hollywood glamour, the style that will live forever. Striking, demure and modest, we would die to see you on the siliver screen. While its called old hollywood, but there's nothing old about you. You often choose bold playful colors and details that tickles our hearts. You've got the spunk of Audrey Hepburn in 'Funny Face' who took our hearts away in Givenchy. Your vintage style makes us feel alive. Bless us with your entrance as we couldn't be any more delighted for your beauty and style."],
 "Jennifer Lawrence"  => ['jlaw', "You are an astonishing modern woman. Clean sharp lines are your favorite and you get very playful with them. You love a cut out detail, it brings out the sexy in you without negating the unique style you love so much. You spice up your look by playing with textures, prints or nontraditional shapes. We can't take our eyes off you. You are nothing but a contemporary dream that we are thrilled to see."]}.each do |name, details|
  c = ShareQuizCategorization.find_or_create_by(share_quiz: red_carpet_quiz, name: name, description: details[1])
  c.update_attributes({result_url: "http://res.cloudinary.com/openstile/image/upload/v1487988031/red_carpet_quiz/results/#{details[0]}.jpg",
                       options: {images: ((1..4).map{|num| "http://res.cloudinary.com/openstile/image/upload/c_thumb,h_324,w_250/v1487986857/red_carpet_quiz/#{details[0]}_#{num}.jpg"})}})
end

if ENV["demo_up"]
  location = Location.create!(address: '2439 Fake Street, Brooklyn, NY 11213',
                              neighborhood: 'Williamsburg')

  description = <<EOF
Violet is a boutique with serious personality, known for great basics, handmade local design collaborations,
awesome gifting, the #bunnieseatingpizza greeting card series, and an ever-evolving selection of clothes and shoes that
don't break the bank. We love share tools that help explore identity, play with. We love helping people discover and
express who they are.
EOF

  retailer = Retailer.create!(name: 'Violet Boutique',
                              description: description,
                              location: location,
                              size_range: '00 (XS) - 20 (XXL)',
                              quote: 'Where affordability meets style',
                              price_index: 2,
                              status: 1,
                              above_fold_image: 'http://placehold.it/1900x1080&text=Violet')

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

  retailer.create_user!(first_name: 'Julie', last_name: 'Owner', email: 'julie@store.com',
                        user_role: UserRole.find_by_name(UserRole::RETAILER), password: 'foobar',
                        password_confirmation: 'foobar', confirmed_at: DateTime.now)
end

if ENV["demo_down"]
  Retailer.destroy_all
end

if ENV["brooklyn_up"]

  unless Retailer.find_by_name('Myths of Creation')

    location = Location.create!(address: '421 Graham Ave, Brooklyn, NY 11211', neighborhood: 'Williamsburg')

    description = <<EOF
Myths of Creation is a boutique with serious personality, known for great basics, handmade local design collaborations,
awesome gifting, the #bunnieseatingpizza greeting card series, and an ever-evolving selection of clothes and shoes that
don't break the bank. We love helping people discover and express who they are.
EOF

    retailer = Retailer.create!(name: 'Myths of Creation', description: description, location: location,
                                size_range: 'XS - L', quote: "Where daring meets practical and never breaks the bank",
                                price_index: 1, status: 1)

    retailer.create_online_presence!(web_link: 'http://mythsofcreation.com',
                                     instagram_link: 'https://www.instagram.com/mythsofcreation/')

    ['2015-11-28', '2015-11-29', '2015-11-30', '2015-12-01', '2015-12-02', '2015-12-03', '2015-12-04'].each do |date|
      retailer.drop_in_availabilities.create!(template_date: date, start_time: '12:00:00', end_time: '20:00:00',
                                              frequency: DropInAvailability::WEEKLY_FREQUENCY, bandwidth: 2, location: location)
    end

    retailer.create_user!(first_name: 'Xenia', last_name: 'Viray', email: 'xenia@mythsofcreation.com',
                          user_role: UserRole.find_by_name(UserRole::RETAILER), password: 'moc_openstile1128',
                          password_confirmation: 'moc_openstile1128', confirmed_at: Time.zone.now)
  end

  unless Retailer.find_by_name('Jupe')

    location = Location.create!(address: '1387 Carroll St, Brooklyn, NY 11213', neighborhood: 'Crown Heights')

    description = <<EOF
At Jupe, our goal is to handpick the latest fashions at affordable prices while also keeping it modest at the same time.
We pride ourselves in offering a pleasant and fun shopping experience.
EOF

    retailer = Retailer.create!(name: 'Jupe', description: description, location: location,
                                size_range: 'XS - L', quote: "Where affordability meets style",
                                price_index: 1, status: 1)

    retailer.create_online_presence!(web_link: 'http://www.jupenyc.com/',
                                     facebook_link: 'https://www.facebook.com/JupeNYC/',
                                     instagram_link: 'https://www.instagram.com/jupenyc/')

    retailer.drop_in_availabilities.create!(template_date: '2015-11-29', start_time: '12:00:00', end_time: '16:00:00',
                                            frequency: DropInAvailability::WEEKLY_FREQUENCY, bandwidth: 2, location: location)
    retailer.drop_in_availabilities.create!(template_date: '2015-11-30', start_time: '15:00:00', end_time: '18:00:00',
                                            frequency: DropInAvailability::WEEKLY_FREQUENCY, bandwidth: 2, location: location)
    retailer.drop_in_availabilities.create!(template_date: '2015-12-01', start_time: '12:00:00', end_time: '15:30:00',
                                            frequency: DropInAvailability::WEEKLY_FREQUENCY, bandwidth: 2, location: location)
    retailer.drop_in_availabilities.create!(template_date: '2015-12-02', start_time: '19:00:00', end_time: '22:00:00',
                                            frequency: DropInAvailability::WEEKLY_FREQUENCY, bandwidth: 2, location: location)
    retailer.drop_in_availabilities.create!(template_date: '2015-12-03', start_time: '12:00:00', end_time: '15:30:00',
                                            frequency: DropInAvailability::WEEKLY_FREQUENCY, bandwidth: 2, location: location)

    retailer.create_user!(first_name: 'Shayna', last_name: 'Capland', email: 'Lejupe@gmail.com',
                          user_role: UserRole.find_by_name(UserRole::RETAILER), password: 'jupe_openstile1128',
                          password_confirmation: 'jupe_openstile1128', confirmed_at: Time.zone.now)
  end

  unless Retailer.find_by_name('Lady J +1')

    location = Location.create!(address: '679 Classon Ave, Brooklyn, NY 11238', neighborhood: 'Crown Heights')

    description = <<EOF
A local favorite among the artsy and eclectic residents of Crown Heights, Brooklyn. Lady J +1 features some of Brooklyn's
best indie designers starting with the in-house-made jewelry brand Lady J Jewelry. In addition to clothing the store also
features an apothecary section, artisanal ceramics and other unique gifting items.
EOF

    retailer = Retailer.create!(name: 'Lady J +1', description: description, location: location,
                                size_range: 'S - L', quote: "Brooklyn's best indie designers",
                                price_index: 2, status: 1)

    retailer.create_online_presence!(web_link: 'http://www.ladyjjewelry.com',
                                     instagram_link: 'https://www.instagram.com/ladyjjewelry/',
                                     facebook_link: 'https://www.facebook.com/LadyJJewelry',
                                     twitter_link: 'https://twitter.com/LadyJJewelry')

    retailer.drop_in_availabilities.create!(template_date: '2016-01-13', start_time: '12:00:00', end_time: '19:00:00',
                                            frequency: DropInAvailability::WEEKLY_FREQUENCY, bandwidth: 2, location: location)
    retailer.drop_in_availabilities.create!(template_date: '2016-01-14', start_time: '12:00:00', end_time: '19:00:00',
                                            frequency: DropInAvailability::WEEKLY_FREQUENCY, bandwidth: 2, location: location)
    retailer.drop_in_availabilities.create!(template_date: '2016-01-15', start_time: '12:00:00', end_time: '19:00:00',
                                            frequency: DropInAvailability::WEEKLY_FREQUENCY, bandwidth: 2, location: location)
    retailer.drop_in_availabilities.create!(template_date: '2016-01-16', start_time: '12:00:00', end_time: '19:00:00',
                                            frequency: DropInAvailability::WEEKLY_FREQUENCY, bandwidth: 2, location: location)
    retailer.drop_in_availabilities.create!(template_date: '2016-01-17', start_time: '12:00:00', end_time: '18:00:00',
                                            frequency: DropInAvailability::WEEKLY_FREQUENCY, bandwidth: 2, location: location)

    retailer.create_user!(first_name: 'Jessica', last_name: "D'Amico", email: 'ladyjjewelry@gmail.com',
                          user_role: UserRole.find_by_name(UserRole::RETAILER), password: 'ljj_openstile1128',
                          password_confirmation: 'ljj_openstile1128', confirmed_at: Time.zone.now)
  end

  unless Retailer.find_by_name('3NY')

    location = Location.create!(address: '300 Bleecker St, New York, NY 10014', neighborhood: 'West Village')

    description = <<EOF
3NY is a multi-Personality Brand catering to New York City's fashion gurus: The Classicist, who embrace tradition;
The Maverick, who creates her own trends; and the Eclectics, who follow their heart...Nothing is ever off limits.
Customers will find pieces from 3NY that will keep them on-trend for the season, as well as make an excellent addition
to their wardrobe for years to come. The uniqueness of 3NY's offerings promise to make any fashion-conscious woman
stand out from the rest.
EOF

    retailer = Retailer.create!(name: '3NY', description: description, location: location,
                                size_range: '0 (XS) - 12 (L)', quote: "The Maverick who creates her own trends",
                                price_index: 3, status: 1)

    retailer.create_online_presence!(web_link: 'http://www.3nyboutiques.com',
                                     instagram_link: 'https://www.instagram.com/Shop3NY',
                                     facebook_link: 'https://www.facebook.com/3NYBOUTIQUES')

    retailer.drop_in_availabilities.create!(template_date: '2016-02-01', start_time: '10:30:00', end_time: '19:30:00',
                                            frequency: DropInAvailability::WEEKLY_FREQUENCY, bandwidth: 2, location: location)
    retailer.drop_in_availabilities.create!(template_date: '2016-02-02', start_time: '10:30:00', end_time: '19:30:00',
                                            frequency: DropInAvailability::WEEKLY_FREQUENCY, bandwidth: 2, location: location)
    retailer.drop_in_availabilities.create!(template_date: '2016-02-03', start_time: '10:30:00', end_time: '19:30:00',
                                            frequency: DropInAvailability::WEEKLY_FREQUENCY, bandwidth: 2, location: location)
    retailer.drop_in_availabilities.create!(template_date: '2016-02-04', start_time: '10:30:00', end_time: '19:30:00',
                                            frequency: DropInAvailability::WEEKLY_FREQUENCY, bandwidth: 2, location: location)
    retailer.drop_in_availabilities.create!(template_date: '2016-02-05', start_time: '10:30:00', end_time: '19:30:00',
                                            frequency: DropInAvailability::WEEKLY_FREQUENCY, bandwidth: 2, location: location)
    retailer.drop_in_availabilities.create!(template_date: '2016-02-06', start_time: '10:30:00', end_time: '20:00:00',
                                            frequency: DropInAvailability::WEEKLY_FREQUENCY, bandwidth: 2, location: location)
    retailer.drop_in_availabilities.create!(template_date: '2016-02-07', start_time: '11:00:00', end_time: '19:00:00',
                                            frequency: DropInAvailability::WEEKLY_FREQUENCY, bandwidth: 2, location: location)

    retailer.create_user!(first_name: 'Sam', last_name: 'Desner', email: 'tania@3nyboutiques.com',
                          user_role: UserRole.find_by_name(UserRole::RETAILER), password: '3ny_openstile1128',
                          password_confirmation: '3ny_openstile1128', confirmed_at: Time.zone.now)
  end

  unless Retailer.find_by_name('AK Couture Boutique & Beauty Bar')

    location = Location.create!(address: '4516 Church Avenue, Brooklyn, New York 11203', neighborhood: 'Flatbush')

    description = <<EOF
Our vision is to become the primary source of great finds for universally fashionable women and men.
Here independent designers rule and our pieces are sure to set you apart from the rest! Our Beauty Bar features a range of hygiene and beauty products such as organic handmade soaps.
AK Couture caters to fashion forward men and woman of all ages and will maintain the "Zulema N. George" trademark of great fashion without having to spend a fortune.
EOF

    retailer = Retailer.create!(name: 'AK Couture Boutique & Beauty Bar', description: description, location: location,
                                size_range: 'S - 3XL', quote: "How Are U This Epic?",
                                price_index: 1, status: 1)

    retailer.create_online_presence!(web_link: 'http://www.iloveakcouture.com/',
                                     instagram_link: 'https://www.instagram.com/akcouture',
                                     facebook_link: 'https://www.facebook.com/akcouture',
                                     twitter_link: 'https://www.twitter.com/akcouturebbb')

    retailer.drop_in_availabilities.create!(template_date: '2016-05-24', start_time: '11:00:00', end_time: '18:00:00',
                                            frequency: DropInAvailability::WEEKLY_FREQUENCY, bandwidth: 2, location: location)
    retailer.drop_in_availabilities.create!(template_date: '2016-05-25', start_time: '11:00:00', end_time: '18:00:00',
                                            frequency: DropInAvailability::WEEKLY_FREQUENCY, bandwidth: 2, location: location)
    retailer.drop_in_availabilities.create!(template_date: '2016-05-26', start_time: '11:00:00', end_time: '18:00:00',
                                            frequency: DropInAvailability::WEEKLY_FREQUENCY, bandwidth: 2, location: location)
    retailer.drop_in_availabilities.create!(template_date: '2016-05-27', start_time: '10:00:00', end_time: '18:00:00',
                                            frequency: DropInAvailability::WEEKLY_FREQUENCY, bandwidth: 2, location: location)
    retailer.drop_in_availabilities.create!(template_date: '2016-05-28', start_time: '10:00:00', end_time: '18:00:00',
                                            frequency: DropInAvailability::WEEKLY_FREQUENCY, bandwidth: 2, location: location)


    retailer.create_user!(first_name: 'Zulema', last_name: 'George', email: 'imagebyak@aol.com',
                          user_role: UserRole.find_by_name(UserRole::RETAILER), password: 'akcouture_openstile1128',
                          password_confirmation: 'akcouture_openstile1128', confirmed_at: Time.zone.now)
  end
end


