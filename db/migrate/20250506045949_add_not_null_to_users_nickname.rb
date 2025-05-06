class AddNotNullToUsersNickname < ActiveRecord::Migration[7.1]
  def change
    change_column_null :users, :nickname, false
  end
end
