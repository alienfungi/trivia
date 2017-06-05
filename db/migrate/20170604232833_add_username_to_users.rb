class AddUsernameToUsers < ActiveRecord::Migration[5.1]
  def up
    add_column :users, :username, :string, unique: true, default: ""
    User.order(:created_at).find_each.with_index do |user, index|
      user.update_attribute(:username, "user_#{ index }")
    end
    change_column_null :users, :username, false
    add_index :users, :username, unique: true
  end

  def down
    remove_index :users, :username
    remove_column :users, :username
  end
end
