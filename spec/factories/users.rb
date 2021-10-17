FactoryBot.define do
  factory :user do
    japanese_user = Gimei.unique.name
    email                 { Faker::Internet.free_email }
    password              { Faker::Lorem.characters(number: 6, min_alpha: 1, min_numeric: 1) }
    password_confirmation { password }
    last_name             { Gimei.unique.name.last.kanji }
    first_name            { Gimei.unique.name.first.kanji }
    last_name_kana        { Gimei.unique.name.last.katakana }
    first_name_kana       { Gimei.unique.name.first.katakana }
    company               { Faker::Company.unique.industry }
    company_form_id       { Faker::Number.between(from: 1, to: 5) }
    department            { Faker::Company.profession }
    phone_number          { '090-1234-5678' }
    birth_day             { '1980-12-31' }
  end
end
