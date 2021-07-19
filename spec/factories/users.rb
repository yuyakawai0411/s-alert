FactoryBot.define do
  factory :user do
    japanese_user = Gimei.name
    email                 { Faker::Internet.free_email }
    password              { Faker::Lorem.characters(number: 6, min_numeric: 1) }
    password_confirmation { password }
    last_name             { japanese_user.last.kanji }
    first_name            { japanese_user.first.kanji }
    last_name_kana        { japanese_user.last.katakana }
    first_name_kana       { japanese_user.first.katakana }
    company               { Faker::Company.name }
    company_form_id       { Faker::Number.between(from: 1, to: 5) }
    department            { Faker::Company.profession }
    phone_number          { '090-1234-5678' }
    birth_day             { '1980-12-31' }
  end
end
