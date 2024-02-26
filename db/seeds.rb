user = User.new(:name => 'user', :email => 'user@example.com', :password => 'password1', :admin => false)
user.save!


admin = User.new(:name => 'admin1', :email => 'admin1@example.com', :password => 'password1', :admin => true)
admin.save!

5.times do |n|
  Item.create!(
    name: "item#{n + 1}",
    character: "character#{n + 1}",
    category: rand(0..4),
    user: user
  )
end

5.times do |n|
  Item.create!(
    name: "商品#{n + 1}",
    character: "キャラクター#{n + 1}",
    category: rand(0..4),
    user: user
  )
end

5.times do |n|
  OwnedItem.create!(
    quantity: n + 1,
    user: user,
    item: Item.find_by(name: "item#{n + 1}")
  )
end

5.times do |n|
  WantedItem.create!(
    quantity: n + 1,
    user: user,
    item: Item.find_by(name: "商品#{n + 1}")
  )
end

5.times do |n|
    
  Label.create!(
    name: "ラベル#{n + 1}",
    user: user,
  )
end

