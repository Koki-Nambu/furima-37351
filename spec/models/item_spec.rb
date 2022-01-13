require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '出品機能' do
    context '出品が保存できる時' do
      it '画像,商品名,商品説明,カテゴリー,状態,送料,発送元地域,発送までの日数,価格,ユーザとの紐付き,全てあれば保存できる' do
        expect(@item).to be_valid
      end
    end
    context '出品が保存できない時' do
      it '画像がなければ保存できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it '商品名がなければ保存できない' do
        @item.title = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Title can't be blank")
      end

      it '商品説明がなければ保存できない' do
        @item.explanation = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Explanation can't be blank")

      end

      it 'カテゴリーが未選択だと保存できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category Can't be blank")
      end

      it '状態が未選択だと保存できない' do
        @item.status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Status Can't be blank")
      end

      it '送料が未選択だと保存できない' do
        @item.delivery_charge_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery charge Can't be blank")
      end

      it '発送元地域が未選択だと保存できない' do
        @item.shipping_area_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping area Can't be blank")
      end

      it '発送までの日数が未選択だと保存できない' do
        @item.days_to_ship_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Days to ship Can't be blank")
      end

      it '価格が空では保存できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price Can't be blank")
      end

      it '価格が¥300以下だと保存できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
      end

      it '価格が¥9,999,999以上だと保存できない' do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
      end

      it 'ユーザーが紐付いていなければ保存できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("User must exist")
      end
    end
  end
end
