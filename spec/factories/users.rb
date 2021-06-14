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
    department            { Faker::Company.profession }
  end
end
