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

["Bohemian Chic/Hipster", "Preppy", "Casual/Relaxed", 
 "Classic/Vintage", "Edgy/Rocker", "Romantic/Girly", "Glamorous/Diva"].each do |look|
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
