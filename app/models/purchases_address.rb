class PurchasesAddress
  include ActiveModel::Model 
  attr_accessor :post_code, :shipping_area_id, :municipalities, :address, :building_name, :telephone_number, :purchases_record_id, :user_id, :item_id, :token



  with_options presence: true do
    validates :post_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, allow_blank: true}, presence: { message: "例）123-4567"}
    validates :shipping_area_id, numericality: {other_than: 1}
    validates :municipalities, :address
    validates :telephone_number, format: {with: /\d{10,11}/, allow_blank: true}, length: {maximum: 11}
    validates :user_id
    validates :item_id
    validates :token
  end

  def save
    purchases_address = PurchasesRecord.create(user_id: user_id, item_id: item_id)
    ShippingAddress.create(post_code: post_code, shipping_area_id: shipping_area_id, municipalities: municipalities, address: address, building_name: building_name, telephone_number: telephone_number, purchases_record_id: purchases_address.id)
  end
end