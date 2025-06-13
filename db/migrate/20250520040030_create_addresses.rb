class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.string :postal_code
      t.integer :prefecture_id
      t.string :city
      t.string :addresses
      t.string :building
      t.string :phone_number
      t.references :buyer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
