class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :company_name
      t.string :namespace
      t.references :admin, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
