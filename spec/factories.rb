FactoryBot.define do
  factory :category do
    name { Faker.constants.sample }
  end

  factory :user do
    email { Faker::Internet.email }
    password { "111111" }
  end

  factory :teacher, class: User do
    email { Faker::Internet.email }
    password { "111111" }
    teacher { true }
  end

  factory :tutorial do
    association :user, factory: [:teacher]
    title { Faker::Job.field }
    price { rand(50..200) }
    price_type { rand(0..1) }
    expiration { rand(5..30) }
    catagory { rand(0..2) }
    available { true }
    url { Faker::Internet.url }
    desc { Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false) }
  end
  
end