class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true

  ZENKAKU_REGEX       = /\A[ぁ-んァ-ン一-龥々ー]+\z/
  ZENKAKU_KATA_REGEX  = /\A[ァ-ヶー]+\z/
  VALID_PASSWORD_REGEX = /\A(?=.*\d)(?=.*[a-zA-Z])[a-zA-Z0-9]+\z/
  validates :password,format: { with: VALID_PASSWORD_REGEX,message: 'is invalid. Include both letters and numbers' }
  validates :last_name,        presence: true, format: { with: ZENKAKU_REGEX }
  validates :first_name,       presence: true, format: { with: ZENKAKU_REGEX }
  validates :kana_last_name,   presence: true, format: { with: ZENKAKU_KATA_REGEX }
  validates :kana_first_name,  presence: true, format: { with: ZENKAKU_KATA_REGEX }
  validates :birthday,         presence: true

end
