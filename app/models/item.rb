class Item < ApplicationRecord
    belongs_to :user
    has_one_attached :image
    has_one :purchases_record 
  
    extend ActiveHash::Associations::ActiveRecordExtensions
    belongs_to :category
    belongs_to :days_to_ship
    belongs_to :shipping_area
    belongs_to :delivery_charge
    belongs_to :status

    validates :image, presence: true
    validates :title, :explanation, presence: true
    validates :category_id, :days_to_ship_id, :shipping_area_id, :delivery_charge_id, :status_id, numericality: { other_than: 1 , message: "Can't be blank"} 
    
    with_options presence: true, format: { with: /\A[0-9]+\z/ } do
      validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 },
                        presence: { message: "Can't be blank" }
    end
  
end
