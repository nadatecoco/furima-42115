class Item < ApplicationRecord
  # ActiveHash の関連（category など）を有効化
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  belongs_to :category
  belongs_to :condition
  belongs_to :fee_burden
  belongs_to :origin_area
  belongs_to :days_until_shipping

  validates :title, presence: true
  validates :description, presence: true
  validates :category_id, presence: true
  validates :condition_id, presence: true
  validates :fee_burden_id, presence: true
  validates :origin_area_id, presence: true
  validates :days_until_shipping_id, presence: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }
end
