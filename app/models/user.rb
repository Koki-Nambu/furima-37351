class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: "is invalid"

  validates :nickname, presence: true

  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: '全角文字を使用してください' } do
    validates :first_name_full_width, :last_name_full_width
  end

  with_options presence: true, format: { with: /\A[ァ-ヶー]+\z/, message: '全角カタカナを入力してください' } do
    validates :first_name_kana
    validates :last_name_kana
  end

  validates :date_of_birth, presence: true

end
