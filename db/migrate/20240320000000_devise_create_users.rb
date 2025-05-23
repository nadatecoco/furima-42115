class DeviseCreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at


      t.string :nickname,           null: false
      t.string :last_name,          null: false
      t.string :first_name,         null: false
      t.string :kana_last_name,     null: false
      t.string :kana_first_name,    null: false
      t.date   :birthday,           null: false

      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true

  end
end 