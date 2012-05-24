FactoryGirl.define do
  factory :user do
    name     "Test User"
    email    "test@email.com"
    password "foobar"
    password_confirmation "foobar"
  end
end
