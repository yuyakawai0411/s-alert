FactoryBot.define do
  factory :card do
    japanese_user = Gimei.unique.name
    s_last_name             { Gimei.unique.name.last.kanji }
    s_first_name            { Gimei.unique.name.first.kanji }
    s_last_name_kana        { Gimei.unique.name.last.katakana }
    s_first_name_kana       { Gimei.unique.name.first.katakana }
    s_company               { Faker::Company.unique.industry }
    s_company_form_id       { Faker::Number.between(from: 1, to: 5) }
    s_department            { Faker::Company.unique.profession }
    s_phone_number          { Faker::Number.between(from: 0o000000000, to: 99_999_999_999) }
    s_birth_day             { Faker::Date.between(from: '1930-01-01', to: '2016-12-31') }
    s_hobby_top             { "ゴルフ" }
    s_hobby_medium          { "水泳" }
    s_hobby_row             { "漫画鑑賞" }
    association :user


    after(:build) do |card|
      card.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end

  end
end
