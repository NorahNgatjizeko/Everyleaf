# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do |index|
	User.create!(
	    name: Faker::Name.name,
	    email: Faker::Internet.email,
	    password: "password",
	    password_confirmation: "password",
	)
end

10.times do |index|
 User.create!( name: "admin",
                 email: "admin@gmail.com",
                 password: "123456",
                 password_confirmation: "123456",
                 admin: true )
 		end

10.times do |id|
	Label.create!(
		      id: id,
		      name: Faker::Verb.past_participle,
		   )
end

10.times do |n|
		Labelling.create!(task_id: rand(1..20), label_id: rand(1..3))
end
