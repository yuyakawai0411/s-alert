FactoryBot.define do
  factory :record do
    phone_day             { Faker::Date.between_except(from: 1.year.ago, to: 1.year.from_now, excepted: Date.today) }
    phone_time_id         { Faker::Number.between(from: 1, to: 24) }
    expression_id         { Faker::Number.between(from: 1, to: 24) }
    association :card
  end
end
