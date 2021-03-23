# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(email: 'info@tobiasbohn.com', password: Rails.application.credentials[:seed_password])
user.confirm
user1 = User.create(email: 'info1@tobiasbohn.com', password: Rails.application.credentials[:seed_password])
user1.confirm
user2 = User.create(email: 'info2@tobiasbohn.com', password: Rails.application.credentials[:seed_password])
user2.confirm

(1..25).each do |index|
  user = User.create(email: "nutzer#{index}@demo-account.de", password: "domicile-demo")
  user.confirm
end
