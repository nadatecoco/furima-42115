class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  # has_one :buyer
  belongs_to :user
  has_one_attached :image

  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :fee_burden
  belongs_to_active_hash :origin_area
  belongs_to_active_hash :days_until_shipping

  with_options presence: true do
    validates :image
    validates :title
    validates :description
  end

  with_options numericality: { other_than: 1, message: "can't be blank" } do
    validates :category_id
    validates :condition_id
    validates :fee_burden_id
    validates :origin_area_id
    validates :days_until_shipping_id
  end

  validates :price, presence: true,
                    numericality: {
                      greater_than_or_equal_to: 300,
                      less_than_or_equal_to: 9_999_999,
                      only_integer: true,
                      allow_blank: true
                    }
  def was_attached?
    image.attached?
  end
end
