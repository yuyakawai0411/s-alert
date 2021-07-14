FactoryBot.define do
  factory :record do
    date             { Faker::Date.between_except(from: 1.year.ago, to: 1.year.from_now, excepted: Date.today) }
    phone_time_id    { Faker::Number.between(from: 7, to: 22) }
    expression_id    { Faker::Number.between(from: -3, to: 3) }
    phone_call_id    { Faker::Number.between(from: 1, to: 2) }
    association :card
  end
end
