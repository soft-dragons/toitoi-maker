# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
Faker::Config.locale = :ja

user = User.create!(
  name: Faker::Name.unique.name,
  email: "test@123456",
  password: "test123456",
  point: 15
)

problem = Problem.create!(
  user_id: user.id,
  title: "といとい問題そのいち",
  statement: "問題の内容が記載されます。問題の内容が記載されます。\n問題の内容が記載されます。問題の内容が記載されます。\n",
  answer: Faker::Hacker.adjective,
  incorrect1: Faker::Computer.type,
  incorrect2: Faker::Hacker.ingverb,
  created_at: Date.today - 3,
  updated_at: Date.today - 3
)

3.times do |n|
  Answer.create!(
    user_id: user.id,
    problem_id: problem.id,
    result: false,
    created_at: Date.today - 3,
    updated_at: Date.today - 3
    )
end

19.times do |n|
  User.create!(
    name: Faker::Name.unique.name,
    email: Faker::Internet.unique.email,
    password: Faker::Internet.unique.password(min_length: 6, max_length: 128),
    point: n
  )
end

20.times do |n|
  User.where('id = ?', rand(User.first.id .. User.last.id)).each do |user|
    problem = user.problems.create!(
      title: "といとい問題"+(n+1).to_s,
      statement: "問題の内容が記載されます。問題の内容が記載されます。\n問題の内容が記載されます。問題の内容が記載されます。\n",
      answer: Faker::Hacker.adjective,
      incorrect1: Faker::Computer.type,
      incorrect2: Faker::Hacker.ingverb,
      created_at: Date.today - 6,
      updated_at: Date.today - 6
    )
  end
end

20.times do |n|
  User.where('id = ?', rand(User.first.id .. User.last.id)).each do |user|
    problem = user.problems.create!(
      title: "といとい問題"+(n+1).to_s,
      statement: "問題の内容が記載されます。問題の内容が記載されます。\n問題の内容が記載されます。問題の内容が記載されます。\n",
      answer: Faker::Hacker.adjective,
      incorrect1: Faker::Computer.type,
      incorrect2: Faker::Hacker.ingverb,
      created_at: Date.today - 3,
      updated_at: Date.today - 3
    )
  end
end

10.times do |n|
  User.where('id = ?', rand(User.first.id .. User.last.id)).each do |user|
    problem = user.problems.create!(
      title: "といとい問題"+(n+1).to_s,
      statement: "問題の内容が記載されます。問題の内容が記載されます。\n問題の内容が記載されます。問題の内容が記載されます。\n",
      answer: Faker::Hacker.adjective,
      incorrect1: Faker::Computer.type,
      incorrect2: Faker::Hacker.ingverb
    )
  end
end

70.times do |n|
  User.where('id = ?', rand(User.first.id .. User.last.id)).each do |user|
    problem = Problem.order("RANDOM()").limit(1)
    answer = user.answers.create!(
      problem_id: problem[0].id,
      result: Faker::Boolean.boolean
    )
    feedback = user.feedbacks.create!(
      problem_id: problem[0].user_id,
      text: "コメントです！コメントです！\nコメントです！コメントです！\n"
    ) unless problem[0].user_id == user.id
  end
end