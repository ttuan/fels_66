User.create!(name: "long",
             email: "long@gmail.com",
             password: "123123",
             password_confirmation: "123123",
             admin: true)

50.times do |n|
  name = "long_#{n+1}"
  email = "example-#{n+1}@gmail.com"
  password = "drowssap"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end

10.times do |n|
  name = "category_#{n+1}"
  Category.create!(name: name,
                   created_at: Time.zone.now,
                   updated_at: Time.zone.now)
end

30.times do |n|
  name = "Word_#{n}"
  Word.create!(alphabet: name,
               category_id: 1,
               created_at: Time.zone.now,
               updated_at: Time.zone.now)

  4.times do |m|
    name = "Answer_#{m}"
    Answer.create!(ans: name,
                   status: m == 0 ? 1 : 0,
                   word_id: n,
                   created_at: Time.zone.now,
                   updated_at: Time.zone.now)
  end
end
