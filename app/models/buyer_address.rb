class BuyerAddress
  include ActiveModel::Model

  attr_accessor :postal_code, :prefecture_id, :city, :addresses,
                :building, :phone_number, :user_id, :item_id, :token

  validates :postal_code,  format: { with: /\A[0-9]{3}-[0-9]{4}\z/ }
  validates :prefecture_id, numericality: { other_than: 1 }
  validates :phone_number,  format: { with: /\A[0-9]{10,11}\z/ }

  with_options presence: true do
    validates :postal_code
    validates :prefecture_id
    validates :city
    validates :addresses
    validates :phone_number
    validates :token
    validates :user_id
    validates :item_id
  end

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
