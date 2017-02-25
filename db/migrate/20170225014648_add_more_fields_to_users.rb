class AddMoreFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :actual_password, :string
  end
end
