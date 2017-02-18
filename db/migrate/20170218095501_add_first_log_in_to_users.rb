class AddFirstLogInToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_first_login, :boolean
  end
end
