class BuyerAddress
  include ActiveModel::Model

  attr_accessor :postal_code, :prefecture_id, :city, :addresses, :building, :phone_number, :user_id, :item_id, :token

  validates :postal_code, presence: true, format: { with: /\A[0-9]{3}-[0-9]{4}\z/ }
  validates :prefecture_id, presence: true, numericality: { other_than: 1 }
  validates :city, presence: true
  validates :addresses, presence: true
  validates :phone_number, presence: true, format: { with: /\A[0-9]{10,11}\z/ }
  validates :token, presence: true
  validates :user_id, presence: true
  validates :item_id, presence: true

  def save
    buyer = Buyer.create(item_id: item_id, user_id: user_id)
    Address.create(
      postal_code: postal_code,
      prefecture_id: prefecture_id,
      city: city,
      addresses: addresses,
      building: building,
      phone_number: phone_number,
      buyer_id: buyer.id
    )
  end
end
