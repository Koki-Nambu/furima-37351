FactoryBot.define do
  factory :purchases_address do
    token {"tok_abcdefghijk00000000000000000"}
    post_code { "123-4567"}
    shipping_area_id {2}
    municipalities {"丸丸市"}
    address {"丸丸1-2-3"}
    building_name {"丸丸ハイツ101"}
    telephone_number {"12345678910"}
  end
end
