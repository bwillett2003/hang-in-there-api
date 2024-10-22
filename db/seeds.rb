# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Poster.create(name: "REGRET",
               description: "Hard work rarely pays off.",
               price: 89.00,
               year: 2018,
               vintage: true,
               img_url:  "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d")

Poster.create(name: "DEFEAT",
               description: "It's too late to start now.",
               price: 35.00,
               year: 2023,
               vintage: false,
               img_url:  "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d")

Poster.create(name: "DESPAIR",
               description: "Let someone else do it; youll just mess it up.",
               price: 73.00,
               year: 2015,
               vintage: false,
               img_url:  "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d")