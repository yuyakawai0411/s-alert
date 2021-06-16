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
    s_phone_number          { Faker::Number.between(from: 0o000000000, to: 99_999_999_999) }
    s_birth_day             { Faker::Date.between(from: '1930-01-01', to: '2016-12-31') }
    association :user


    after(:build) do |card|
      card.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end

  end
end
