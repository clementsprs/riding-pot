# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Creating the users..."

user1 = User.create([{ first_name: 'Clement' }, { last_name: 'Spiers' }, { username: 'Contadordu50' }, { username: 'Contadordu50' }, { email: 'clement@gmail.com' }, { password: 'clement@' }, { avatar: '' } ])
User.create(name: 'DHH')

puts "Seeding done."
