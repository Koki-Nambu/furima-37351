FactoryBot.define do
  factory :item do
    title {Faker::Name.name}
    explanation {Faker::Lorem.sentence}
    category_id {2}
    status_id {2}
    delivery_charge_id {2}
    shipping_area_id {2}
    days_to_ship_id {2}
    price {5000}
    association :user, factory: :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.jpeg'), filename: 'test_image.jpeg')
    end
  end
end
