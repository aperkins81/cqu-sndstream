FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Test User #{n}" }
    sequence(:email) { |n|"test-#{n}@email.com" }
    password "foobar"
    password_confirmation "foobar"
    
    factory :admin do
      admin true
    end
  end
  
  factory :soundpost do
    content "Binary Data 00110101010101000000"
    filetype "test/test"
    ext ".test"
    user
  end
end
