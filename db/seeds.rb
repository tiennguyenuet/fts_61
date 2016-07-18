# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create name: "admin", email: "admin@example.com", role: 1,
  password: "12345678", password_confirmation: "12345678"

20.times do |u|
  User.create! name: "User" + (u+1).to_s,
  email: "user#{u+1}@example.com",
  password: "12345678"
end

20.times do |u|
  Subject.create! name: "Git" + (u+1).to_s,
  description: "Git for beginner",
  total_question: 20,
  duration: 30
end

20.times do |u|
  Examination.create! status: 0,
  user_id: 1,
  subject_id: (u+1)
end