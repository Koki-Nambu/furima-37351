require 'rails_helper'

RSpec.describe PurchasesAddress, type: :model do
  describe '商品購入機能' do
    before do
      @user = FactoryBot.create(:user)
      @item = FactoryBot.create(:item)
      @item.image = fixture_file_upload('public/images/test_image.jpeg')
      @item.save
      @purchases_address = FactoryBot.build(:purchases_address, user_id: @user.id, item_id: @item.id)
      sleep 0.1
    end
    context '商品が購入できる時' do
      it '郵便番号、都道府県、市区町村、番地、建物名、電話番号、トークンが全てあれば購入できる' do
        expect(@purchases_address).to be_valid
      end

      it '建物名がなくても購入できる' do
        @purchases_address.building_name = ''
        expect(@purchases_address).to be_valid
      end
    end
    context '商品が購入できない時' do
      it '郵便番号が空では購入できない' do
        @purchases_address.post_code = ''
        @purchases_address.valid?
        expect(@purchases_address.errors.full_messages).to include("Post code 例）123-4567")
      end

      it '郵便番号にハイフンがなければ保存できない' do
        @purchases_address.post_code = '1234567'
        @purchases_address.valid?
        expect(@purchases_address.errors.full_messages).to include("Post code is invalid")
      end

      it '都道府県が未入力では購入できない' do
        @purchases_address.shipping_area_id = 1
        @purchases_address.valid?
        expect(@purchases_address.errors.full_messages).to include("Shipping area must be other than 1")
      end

      it '市区町村が空では購入できない' do
        @purchases_address.municipalities = ''
        @purchases_address.valid?
        expect(@purchases_address.errors.full_messages).to include("Municipalities can't be blank")
      end

      it '番地が空では購入できない' do
        @purchases_address.address = ''
        @purchases_address.valid?
        expect(@purchases_address.errors.full_messages).to include("Address can't be blank")
      end

      it '電話番号が空では購入できない' do
        @purchases_address.telephone_number = ''
        @purchases_address.valid?
        expect(@purchases_address.errors.full_messages).to include("Telephone number can't be blank")
      end

      it '電話番号にハイフンが含まれている場合は購入できない' do
        @purchases_address.telephone_number = '123-4567-8910'
        @purchases_address.valid?
        expect(@purchases_address.errors.full_messages).to include("Telephone number is invalid")
      end

      it 'トークンが空では購入できない' do
        @purchases_address.token = nil
        @purchases_address.valid?
        expect(@purchases_address.errors.full_messages).to include("Token can't be blank")
      end

      it 'ユーザーが紐付いていなければ購入できない' do
        @purchases_address.user_id = nil
        @purchases_address.valid?
        expect(@purchases_address.errors.full_messages).to include("User can't be blank")
      end

      it '商品が紐付いていなければ購入できない' do
        @purchases_address.item_id = nil
        @purchases_address.valid?
        expect(@purchases_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
