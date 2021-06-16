FactoryBot.define do
  factory :card do
    japanese_user = Gimei.name
    s_last_name             { japanese_user.last.kanji }
    s_first_name            { japanese_user.first.kanji }
    s_last_name_kana        { japanese_user.last.katakana }
    s_first_name_kana       { japanese_user.first.katakana }
    s_company               { Faker::Company.name }
    s_company_form_id       { Faker::Number.between(from: 1, to: 5) }
    s_department            { Faker::Company.profession }
    s_phone_number
    s_birth_day
  end
end
