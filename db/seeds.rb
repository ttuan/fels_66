User.create! name: "User 1",
             email: "example@gmail.com",
             password: "abc123",
             password_confirmation: "abc123",
             admin: true

50.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@gmail.com"
  password = "drowssap"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end

users = User.all
user = users.first
following = users[2..30]
followers = users[3..49]
following.each {|followed| user.follow(followed)}
followers.each {|follower| follower.follow(user)}

