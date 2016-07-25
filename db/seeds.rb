# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(
  name: "admin",
  email: "admin@example.com",
  role: 1,
  password: "12345678")

20.times do |u|
  name = "User" + (u+1).to_s
  email = "user#{u+1}@example.com"
  password = "12345678"
  User.create!(
    name: name,
    email: email,
    password: password)
end
