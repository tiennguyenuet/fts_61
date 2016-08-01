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

2.times do |u|
  name = "User" + (u+1).to_s
  email = "user#{u+1}@example.com"
  password = "12345678"
  User.create!(
    name: name,
    email: email,
    password: password)
end

Subject.create!(name: "Git",
  total_question: 20,
  description: "Learn git",
  duration: "20")


20.times do |i|
  Question.create!(question_type: 0, state: 1, content: "Question#{i+1}", subject_id: 1)
  Answer.create!(content: "Content 1", question_id: i+1,
    is_correct: false)
  Answer.create!(content: "Content 2", question_id: i+1,
    is_correct: false)
  Answer.create!(content: "Content 3", question_id: i+1,
    is_correct: false)
  Answer.create!(content: "Content 4", question_id: i+1,
    is_correct: true)
end
