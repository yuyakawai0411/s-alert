FactoryBot.define do
  factory :record do
    date             { Faker::Date.between_except(from: 1.year.ago, to: 1.year.from_now, excepted: Date.today) }
    phone_time_id          { Faker::Number.between(from: 1, to: 24) }
    expression_id    { Faker::Number.between(from: 1, to: 24) }
    phone_call_id          { Faker::Number.between(from: 0, to: 1) }
    association :card
  end
end
