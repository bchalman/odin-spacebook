# Users

User.create!(name: "Example User",
             email: "example@example.com",
             password: "foobar",
             password_confirmation: "foobar")

99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@example.com"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end


# Friendships

users = User.all
user = users.first
friends = users[2..40]
friends.each {|friend| user.accept_friend_request_from(friend)}


# Posts

users = User.order(:created_at).take(6)

30.times do
  moon = Faker::Space.moon
  content = "Spent much of my youth dreaming about #{moon}."
  users.each { |user| user.posts.create!(content: content) }
end

galaxy = Faker::Space.galaxy
content = "My favorite galaxy is #{galaxy}."
users.each { |user| user.posts.create!(content: content) }
