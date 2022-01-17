class ShippingAddress < ApplicationRecord
  belongs_to :purchases_record

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :shipping_area

  
end
