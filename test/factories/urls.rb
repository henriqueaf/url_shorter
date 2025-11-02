FactoryBot.define do
  factory :url do
    short_code { Faker::Alphanumeric.alphanumeric(number: 4) }
    long_url { Faker::Internet.url }
  end
end
