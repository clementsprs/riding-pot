# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create(name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "open-uri"

puts "Cleaning the database..."

User.destroy_all
Ride.destroy_all
Participation.destroy_all

puts "Creating the users..."

photoclement = URI.open('https://res.cloudinary.com/dv67de4qe/image/upload/v1653919658/clement_hd6uju.png')
user1 = User.new(first_name: 'Clement',   last_name: 'Spiers',   username: 'Contadordu50' ,  email: 'clement@gmail.com' ,  password: 'clement')
user1.photo.attach(io: photoclement, filename: 'clement.png', content_type: 'image/png')
user1.save

photomargaux = URI.open('https://res.cloudinary.com/dv67de4qe/image/upload/v1653919657/photo-margaux_hoh9dh.jpg')
user2 = User.new(first_name: 'Margaux' ,  last_name: 'Pichard' ,  username: 'Margaux_longo' ,  email: 'margaux@gmail.com' ,  password: 'margaux')
user2.photo.attach(io: photomargaux, filename: 'margaux.png', content_type: 'image/png')
user2.save

photocedric = URI.open('https://res.cloudinary.com/dv67de4qe/image/upload/v1653919658/image_bawrw0.png')
user3 = User.new(first_name: 'Cedric' ,  last_name: 'Le Brun' ,  username: 'Cedric_pogacar' ,  email: 'cedric@gmail.com' ,  password: 'cedric')
user3.photo.attach(io: photocedric, filename: 'cedric.png', content_type: 'image/png')
user3.save

photoyohann = URI.open('https://res.cloudinary.com/dv67de4qe/image/upload/v1653919658/yohann-photo_grqcif.jpg')
user4 = User.new(first_name: 'Yohann' ,  last_name: 'Lemasson' ,  username: 'Yohann_amstrong' ,  email: 'yohann@gmail.com' ,  password: 'yohann')
user4.photo.attach(io: photoyohann, filename: 'yohann.png', content_type: 'image/png')
user4.save

puts "Seeding the rides"

ride1 = File.read('db/fixtures/ride1.txt')
ride1 = Ride.new(title: 'Sortie Nantes Sud', user: user1, distance_ride: 60.5, gpx_file: ride1, description: "Je propose une petite sortie dans le sud de Nantes. J'ai dejà fait cet itinéraire et c'est très agréable", elevation: 419, pace_min: 25, pace_max: 28, attendees_max: 30, starting_point: '19 rue de Friedland 44000 Nantes', status: 'done', date: DateTime.parse("03/06/2022"), starting_time: DateTime.parse("03/06/2022 17:00"))
ride1.save

ride2 = File.read('db/fixtures/ride2.txt')
ride2 = Ride.new(title: 'Sortie vers la mer', user: user2, distance_ride: 80.9, gpx_file: ride2, description: "Deuxième édition de ma sortie préférée à Nantes en direction de la mer. Soyez à l'heure ! ", elevation: 428, pace_min: 28, pace_max: 32, attendees_max: 15, starting_point: 'place Graslin Nantes', status: 'upcoming', date: DateTime.parse("06/06/2022"), starting_time: DateTime.parse("06/06/2022 11:00"))
ride2.save

puts "Seeding the participations"

participation1 = Participation.new(user: user2, ride: ride1)
participation1.save
participation2 = Participation.new(user: user1, ride: ride2)
participation2.save
participation3 = Participation.new(user: user3, ride: ride1)
participation3.save
participation4 = Participation.new(user: user4, ride: ride2)
participation4.save

puts "Seeding done."
