FactoryGirl.define do
  factory :user do
    fullname { Faker::Name.name }
    email    { Faker::Internet.email }
    country  { Faker::Address.country }
    password  'password'

    factory :judge do
      is_judge true
    end
  end
end
