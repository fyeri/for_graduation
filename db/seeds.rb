# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

4.times do |n|
  User.find_or_create_by(
    name: 'user#{n + 1}',
    email: 'user#{n + 1}@example.com',
    password: 'password1',
    admin: false
)

admin1 = User.find_or_create_by!(
  name: 'admin1'
  email: 'admin1@example.com'
  password: 'password1'
  admin: true
) 

11.times do |n|
  random_deadline = Date.today + rand(11)

  item = Item.new(
    name: "商品#{n + 1}",
    character: "character#{n + 1}",
    category: 
  )

  owned_item = OwnedItem.new(
    quantity: #{n + 1}
    user: user
    item: item
  )

  labels = %w(ラベル1 ラベル2 ラベル3 ラベル4 ラベル5)
