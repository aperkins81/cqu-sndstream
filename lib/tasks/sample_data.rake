namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_soundposts
    make_relationships
  end
end

def make_users
  admin = User.create!(name: "Andrew P",
               email: "example@example.com",
               password: "foobar",
               password_confirmation: "foobar")
  admin.toggle!(:admin)
  99.times do |n|
    name  = Faker::Name.name
    email = "test-user-#{n+1}@example.com"
    password  = "password"
    User.create!(name: name,
                 email: email,
                 password: password,
                 password_confirmation: password)
  end
end

def make_soundposts
  users = User.all(limit: 6)
  50.times do
    content = "" # make 128 random ones and zeros in groups of 8
    16.times do
      8.times do
        content += rand(2).to_s
      end
      content += " "
    end
    users.each { |user| user.soundposts.create!(content: content, filetype: 'test/test', ext: ".test") }
  end
end

def make_relationships
  users = User.all
  user = users.first
  followed_users = users[2..50]
  followers = users[3..40]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each { |follower| follower.follow!(user) }
end
