class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true
  validates :password, presence: true
  validates :nickname, presence: true

  ZENKAKU_REGEX       = /\A[ぁ-んァ-ン一-龥々ー]+\z/
  ZENKAKU_KATA_REGEX  = /\A[ァ-ヶー]+\z/

  validates :last_name,        presence: true, format: { with: ZENKAKU_REGEX }
  validates :first_name,       presence: true, format: { with: ZENKAKU_REGEX }
  validates :kana_last_name,   presence: true, format: { with: ZENKAKU_KATA_REGEX }
  validates :kana_first_name,  presence: true, format: { with: ZENKAKU_KATA_REGEX }
  validates :birthday,         presence: true

end
