# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

["X-Small", "Small", "Medium", "Large", "X-Large"].each do |size|
  TopSize.find_or_create_by(name: size, category: "alpha")
  BottomSize.find_or_create_by(name: size, category: "alpha")
  DressSize.find_or_create_by(name: size, category: "alpha")
end

["00", "0", "2", "4", "6", "8", "10", "12", "14"].each do |size|
  TopSize.find_or_create_by(name: size, category: "numeric")
  BottomSize.find_or_create_by(name: size, category: "numeric")
  DressSize.find_or_create_by(name: size, category: "numeric")
end

("24".."34").each do |size|
  BottomSize.find_or_create_by(name: size, category: "inches")
end
