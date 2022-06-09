# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create(name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "open-uri"
require "date"
require 'time'

puts "Cleaning the database..."

Comment.destroy_all
User.destroy_all
Ride.destroy_all
Participation.destroy_all

puts "Creating the users..."

photoclement = URI.open('https://res.cloudinary.com/dv67de4qe/image/upload/v1653919658/clement_hd6uju.png')
user1 = User.new(
  first_name: 'Clement',
  last_name: 'Spiers',
  username: 'Contadordu50',
  email: 'clement@gmail.com',
  password: 'clement'
)
user1.photo.attach(io: photoclement, filename: 'clement.png', content_type: 'image/png')
user1.save

photomargaux = URI.open('https://res.cloudinary.com/dv67de4qe/image/upload/v1653919657/photo-margaux_hoh9dh.jpg')
user2 = User.new(
  first_name: 'Margaux',
  last_name: 'Pichard',
  username: 'Margaux_longo',
  email: 'margaux@gmail.com',
  password: 'margaux'
)
user2.photo.attach(io: photomargaux, filename: 'margaux.png', content_type: 'image/png')
user2.save

photocedric = URI.open('https://res.cloudinary.com/dv67de4qe/image/upload/v1653919658/image_bawrw0.png')
user3 = User.new(
  first_name: 'Cedric',
  last_name: 'Le Brun',
  username: 'Cedric_pogacar',
  email: 'cedric@gmail.com',
  password: 'cedric'
)
user3.photo.attach(io: photocedric, filename: 'cedric.png', content_type: 'image/png')
user3.save

photoyohann = URI.open('https://res.cloudinary.com/dv67de4qe/image/upload/v1653919658/yohann-photo_grqcif.jpg')
user4 = User.new(
  first_name: 'Yohann',
  last_name: 'Lemasson',
  username: 'Yohann_amstrong',
  email: 'yohann@gmail.com',
  password: 'yohann'
)
user4.photo.attach(io: photoyohann, filename: 'yohann.png', content_type: 'image/png')
user4.save

photoclarisse = URI.open('https://res.cloudinary.com/dv67de4qe/image/upload/v1654767660/user5_w5ll7r.jpg')
user5 = User.new(
  first_name: 'Clarisse',
  last_name: 'Posti',
  username: 'Clarisse_Ferrand_Prevot',
  email: 'clarisse@gmail.com',
  password: 'clarisse'
)
user5.photo.attach(io: photoclarisse, filename: 'clarisse.png', content_type: 'image/png')
user5.save

photojohn = URI.open('https://res.cloudinary.com/dv67de4qe/image/upload/v1654767658/user6_wujk8b.jpg')
user6 = User.new(
  first_name: 'John',
  last_name: 'Award',
  username: 'John_Valverde',
  email: 'john@gmail.com',
  password: 'john'
)
user6.photo.attach(io: photojohn, filename: 'john.png', content_type: 'image/png')
user6.save

photoremi = URI.open('https://res.cloudinary.com/dv67de4qe/image/upload/v1654767657/user7_szekxu.jpg')
user7 = User.new(
  first_name: 'Remi',
  last_name: 'Boutin',
  username: 'Remi_Bardet',
  email: 'remi@gmail.com',
  password: 'remi'
)
user7.photo.attach(io: photoremi, filename: 'remi.png', content_type: 'image/png')
user7.save

photoedouard = URI.open('https://res.cloudinary.com/dv67de4qe/image/upload/v1654767662/user8_g4qaa1.jpg')
user8 = User.new(
  first_name: 'Edouard',
  last_name: 'Vidal',
  username: 'Edouard_roglic',
  email: 'edouard@gmail.com',
  password: 'edouard'
)
user8.photo.attach(io: photoedouard, filename: 'edouard.png', content_type: 'image/png')
user8.save

puts "Seeding the rides"

ride_1 = File.read('db/fixtures/ride1.txt') #Nantes
ride_2 = File.read('db/fixtures/ride2.txt') #Nantes
ride_3 = File.read('db/fixtures/ride3.txt') #Rennes
ride_4 = File.read('db/fixtures/ride4.txt') #Nantes Ouest
ride_5 = File.read('db/fixtures/ride5.txt') #Nantes Clisson
ride_6 = File.read('db/fixtures/ride6.txt') #Nantes Rouans
ride_7 = File.read('db/fixtures/ride7.txt') #Tour de Grand Lieu
ride_8 = File.read('db/fixtures/ride8.txt') #Rennes Sud
ride_9 = File.read('db/fixtures/ride9.txt') #Rennes


ride1 = Ride.new(
  title: 'Sortie Nantes Sud',
  user: user1,
  distance_ride: 60.5,
  gpx_file: ride_1,
  description: "Je propose une petite sortie dans le sud de Nantes. J'ai dejà fait cet itinéraire et c'est très agréable",
  elevation: 419,
  pace_min: 25,
  pace_max: 28,
  attendees_max: 30,
  starting_point: '19 rue de Friedland 44000 Nantes',
  status: 'done',
  date: DateTime.new(2022,06,05),
  starting_time: DateTime.new(2022, 06, 05, 10, 00, 00)
)
ride1.save

ride2 = Ride.new(
  title: 'Sortie vers la mer',
  user: user2,
  distance_ride: 80.9,
  gpx_file: ride_2,
  description: "Deuxième édition de ma sortie préférée à Nantes en direction de la mer. Soyez à l'heure ! ",
  elevation: 428,
  pace_min: 28,
  pace_max: 32,
  attendees_max: 15,
  starting_point: 'place Graslin Nantes 44000 Nantes',
  status: 'upcoming',
  date: DateTime.new(2022, 06, 11),
  starting_time: DateTime.new(2022, 06, 11, 10, 00, 00)
)
ride2.save

ride3 = Ride.new(
  title: 'Balade autour de Rennes',
  user: user3,
  distance_ride: 101,
  gpx_file: ride_3,
  description: "Parcours retour aux sources à Rennes sur un parcours très agréable et roulant",
  elevation: 429,
  pace_min: 36,
  pace_max: 38,
  attendees_max: 20,
  starting_point: '45 Bd Albert 1er 35200 Rennes',
  status: 'upcoming',
  date: DateTime.new(2022, 06, 11),
  starting_time: DateTime.new(2022, 06, 11, 14, 00, 00)
)
ride3.save

ride4 = Ride.new(
  title: 'Boucle Nantes Nord Est',
  user: user4,
  distance_ride: 92,
  gpx_file: ride_4,
  description: "Parcours plat en campagne, ça va rouler !",
  elevation: 450,
  pace_min: 38,
  pace_max: 40,
  attendees_max: 15,
  starting_point: '78 rue de la Bourgeonnière 44300 Nantes',
  status: 'upcoming',
  date: DateTime.new(2022, 06, 17),
  starting_time: DateTime.new(2022, 06, 16, 14, 00, 00)
)
ride4.save

ride5 = Ride.new(
  title: 'Longue sortie vers Clisson',
  user: user5,
  distance_ride: 114,
  gpx_file: ride_5,
  description: "Boucle très sympa avec un passage devant le chateau de Clisson",
  elevation: 644,
  pace_min: 24,
  pace_max: 28,
  attendees_max: 10,
  starting_point: '24 rue Recteur Schmitt 44300 Nantes',
  status: 'upcoming',
  date: DateTime.new(2022,06,17),
  starting_time: DateTime.new(2022, 06, 17, 10, 00, 00)
)
ride5.save

ride6 = Ride.new(
  title: 'Boucle vers Rouans',
  user: user6,
  distance_ride: 68,
  gpx_file: ride_6,
  description: "Pas mal de point de vue sympa tout le long du parcours, venez en prendre plein les yeux !",
  elevation: 448,
  pace_min: 28,
  pace_max: 30,
  attendees_max: 8,
  starting_point: '87 Rue Saint-Jacques 44200 Nantes',
  status: 'upcoming',
  date: DateTime.new(2022, 06, 17),
  starting_time: DateTime.new(2022, 06, 17, 14, 00, 00)
)
ride6.save

ride7 = Ride.new(
  title: 'Tour du Lac de Grand Lieu depuis Nantes',
  user: user7,
  distance_ride: 79,
  gpx_file: ride_7,
  description: "Parcours sympa pour découvrir le sude de Nantes et le lac de Grand Lieu.",
  elevation: 255,
  pace_min: 30,
  pace_max: 34,
  attendees_max: 18,
  starting_point: '3 Quai Turenne 44000 Nantes',
  status: 'upcoming',
  date: DateTime.new(2022,06,17),
  starting_time: DateTime.new(2022, 06, 17, 14, 30, 00)
)
ride7.save

ride8 = Ride.new(
  title: 'Rennes - Plein Sud !',
  user: user8,
  distance_ride: 78,
  gpx_file: ride_8,
  description: "Viens partager une super sortie dans le sud de Rennes pour aller chercher le soleil...",
  elevation: 530,
  pace_min: 30,
  pace_max: 32,
  attendees_max: 12,
  starting_point: 'Les Préales 35700 Rennes',
  status: 'upcoming',
  date: DateTime.new(2022,06,17),
  starting_time: DateTime.new(2022, 06, 23, 14, 00, 00)
)
ride8.save

ride9 = Ride.new(
  title: 'Tour de Rennes',
  user: user8,
  distance_ride: 95,
  gpx_file: ride_9,
  description: "Une bonne boucle en campagne pour faire le tour de Rennes",
  elevation: 425,
  pace_min: 30,
  pace_max: 32,
  attendees_max: 18,
  starting_point: '111 rue de Lorient 35000 Rennes',
  status: 'upcoming',
  date: DateTime.new(2022, 06, 23),
  starting_time: DateTime.new(2022, 06, 24, 14, 00, 00)
)
ride9.save

puts "Seeding the participations"

# Ride 1
participation11 = Participation.new(user: user2, ride: ride1)
participation11.save
participation12 = Participation.new(user: user3, ride: ride1)
participation12.save
participation13 = Participation.new(user: user4, ride: ride1)
participation13.save

# Ride 2
participation21 = Participation.new(user: user4, ride: ride2)
participation21.save
participation22 = Participation.new(user: user6, ride: ride2)
participation22.save
participation23 = Participation.new(user: user8, ride: ride2)
participation23.save

# Ride 3
participation31 = Participation.new(user: user5, ride: ride3)
participation31.save
participation32 = Participation.new(user: user7, ride: ride3)
participation32.save

# Ride 4
participation41 = Participation.new(user: user2, ride: ride4)
participation41.save
participation42 = Participation.new(user: user3, ride: ride4)
participation42.save
participation43 = Participation.new(user: user5, ride: ride4)
participation43.save
participation44 = Participation.new(user: user6, ride: ride4)
participation44.save
participation45 = Participation.new(user: user7, ride: ride4)
participation45.save

# Ride 5
participation51 = Participation.new(user: user4, ride: ride5)
participation51.save
participation52 = Participation.new(user: user6, ride: ride5)
participation52.save

# Ride 6
participation61 = Participation.new(user: user2, ride: ride6)
participation61.save
participation62 = Participation.new(user: user3, ride: ride6)
participation62.save
participation63 = Participation.new(user: user7, ride: ride6)
participation63.save
participation64 = Participation.new(user: user8, ride: ride6)
participation64.save
participation65 = Participation.new(user: user9, ride: ride6)
participation65.save

# Ride 7

# Ride 8
participation81 = Participation.new(user: user5, ride: ride8)
participation81.save
participation82 = Participation.new(user: user6, ride: ride8)
participation82.save

# Ride 9
participation91 = Participation.new(user: user5, ride: ride8)
participation91.save
participation92 = Participation.new(user: user6, ride: ride8)
participation92.save
participation93 = Participation.new(user: user7, ride: ride9)
participation93.save

puts "Seeding done."
