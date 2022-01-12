require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it 'nicknameとemail、passwordとpassword_confiramation,first_name_full_width,last_name_full_width,first_name_kana,last_name_kana,date_of_birthが存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end
    context '新規登録できない場合' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it '重複したemailでは登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'emailは@を含んでいなければ登録できない' do
        @user.email = 'testgmail.com'
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end

      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it '全角文字を含むパスワードでは登録できない' do
        @user.password = 'あaa000'
        @user.password_confirmation = 'あaa000'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end

      it 'password_confirmationが空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'passwordが6文字以下では登録できない' do
        @user.password = 'aa000'
        @user.password_confirmation = 'aa000'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end

      it 'passwordが数字のみでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end

      it 'passwordが半角英字のみでは登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end

      it 'passwordとpassword_confirmationが一致しなければ登録できない' do
        @user.password = '12345k'
        @user.password_confirmation = '12345t'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it '姓（全角）のfirst_nameが空では登録できない' do
        @user.first_name_full_width = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name full width can't be blank")
      end

      it 'お名前(全角)のlast_nameが空では登録できない' do
        @user.last_name_full_width = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name full width can't be blank")
      end

      it '姓（全角）に半角文字が含まれていると登録できない' do
        @user.first_name_full_width = '田a中'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name full width 全角文字を使用してください")
      end

      it '名（全角）に半角文字が含まれていると登録できない' do
        @user.last_name_full_width = '田a中'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name full width 全角文字を使用してください")
      end

      it '姓カナ（全角)のfirst_nameが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end

      it '名カナ（全角)のlast_nameが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end

      it '姓（カナ）にカタカナ以外の文字（平仮名・漢字・英数字・記号）が含まれていると登録できない' do
        @user.first_name_kana = 'あ亜a/'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana 全角カタカナを入力してください")
      end

      it '名（カナ）にカタカナ以外の文字（平仮名・漢字・英数字・記号）が含まれていると登録できない' do
        @user.last_name_kana = 'あ亜a/'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana 全角カタカナを入力してください")
      end

      it '生年月日が空では登録できない' do
        @user.date_of_birth = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Date of birth can't be blank")
      end
    end
  end
end
