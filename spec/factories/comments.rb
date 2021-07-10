FactoryBot.define do
  factory :comment do
    text { '温泉旅行に行ってました' }
    association :user
    association :card
  end
end
