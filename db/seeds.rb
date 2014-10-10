# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

rattlesnake = Club.create(name: 'Rattlesnake Pit Golf Course')
green = Club.create(name: 'Green Acres')
happy = Club.create(name: "Happy Ernie's Driving Range")

amy = User.create(email: 'amy@coupgon.com', password: 'secret123')

Booking.create(user: amy, club: rattlesnake, time: "2014-12-25 9:00:00")
Booking.create(user: amy, club: green, time: "2014-01-01 12:40:00")