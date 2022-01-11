class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :password,:password_confirmation,length:{minimum:6},format:{with: /(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{7,}/}
  validates :nickname, presence: true
  validates :first_name_full_width, :last_name_full_width, presence:true, format:{with: /\A[ぁ-んァ-ン一-龥]/}
  validates :first_name_kana, :last_name_kana, presence: true, format:{with: /\A[ァ-ヶー－]+\z/}
  validates :date_of_birth, presence: true

end
