FactoryBot.define do
  factory :user do
    transient do
      person { Gimei.name }
   end
    nickname { Faker::Name.name }
    email { Faker::Internet.free_email }
    password = 'aaa000'
    password { password }
    password_confirmation { password }
    first_name_full_width { person.first.kanji }
    last_name_full_width { person.last.kanji }
    first_name_kana { person.first.katakana }
    last_name_kana { person.last.katakana }
    date_of_birth { Faker::Date.birthday(min_age: 18, max_age: 65) }
  end
end