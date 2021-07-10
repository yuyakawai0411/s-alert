FactoryBot.define do
  factory :notice do
    notice_date { '2025-12-31' }
    description { '上司とミーティング' }
    topic       { '漫画鑑賞' }
    association :user
  end
end
