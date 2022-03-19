# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
Faker::Config.locale = :ja

20.times do |n|
  User.create!(
    name: Faker::Name.unique.name,
    email: Faker::Internet.unique.email,
    password: Faker::Internet.unique.password(min_length: 6, max_length: 128),
    point: n
  )
end

50.times do |n|
  User.where('id = ?', rand(User.first.id..User.last.id)).each do |user|
    problem = user.problems.create!(
      title: "といとい問題"+(n+1).to_a,
      statement: "問題の内容が記載されます。問題の内容が記載されます。\n問題の内容が記載されます。問題の内容が記載されます。\n",
      answer: Faker::Computer.stack,
      incorrect1: Faker::Computer.type
      incorrect2: Faker::Hacker.say_something_smart
    )
  end
end

70.times do |n|
  User.where('id = ?', rand(User.first.id..User.last.id)).each do |user|
    problem = rand(Promlem.first.id..Promlem.last.id)
    answer = user.answers.create!(
      problem_id: problem.id
      result: Faker::Boolean.boolean
    )
    unless problem.user_id == user.id
      feedback = user.feedbacks.create!(
       problem_id: problem.user_id
        text: "コメントです！コメントです！\nコメントです！コメントです！\n"
      )
   end
  end
end