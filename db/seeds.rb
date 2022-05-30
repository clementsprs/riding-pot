# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "open-uri"

puts "Creating the users..."

photoclement = URI.open('https://res.cloudinary.com/dv67de4qe/image/upload/v1653919658/clement_hd6uju.png')
user1 = User.new([{ first_name: 'Clement' }, { last_name: 'Spiers' }, { username: 'Contadordu50' }, { email: 'clement@gmail.com' }, { password: 'clement' }])
user1.photo.attach(io: photoclement, filename: 'clement.png', content_type: 'image/png')
user1.save

photomargaux = URI.open('https://res.cloudinary.com/dv67de4qe/image/upload/v1653919657/photo-margaux_hoh9dh.jpg')
user2 = User.new([{ first_name: 'Margaux' }, { last_name: 'Pichard' }, { username: 'Margaux_longo' }, { email: 'margaux@gmail.com' }, { password: 'margaux' }])
user2.photo.attach(io: photomargaux, filename: 'margaux.png', content_type: 'image/png')
user2.save

photocedric = URI.open('https://res.cloudinary.com/dv67de4qe/image/upload/v1653919658/image_bawrw0.png')
user3 = User.new([{ first_name: 'Cedric' }, { last_name: 'Le Brun' }, { username: 'Cedric_pogacar' }, { email: 'cedric@gmail.com' }, { password: 'cedric' }])
user3.photo.attach(io: photocedric, filename: 'cedric.png', content_type: 'image/png')
user3.save

photoyohann = URI.open('https://res.cloudinary.com/dv67de4qe/image/upload/v1653919658/yohann-photo_grqcif.jpg')
user4 = User.new([{ first_name: 'Yohann' }, { last_name: 'Lemasson' }, { username: 'Yohann_amstrong' }, { email: 'yohann@gmail.com' }, { password: 'yohann' }])
user4.photo.attach(io: photoyohann, filename: 'yohann.png', content_type: 'image/png')
user4.save


puts "Seeding done."
