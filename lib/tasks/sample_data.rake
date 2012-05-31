namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
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
  
    users = User.all(limit: 3)
    50.times do
      content = ""
      16.times do
        content += rand(2).to_s
      end
      users.each { |user| user.soundposts.create!(content: content) }
    end
  end
end
