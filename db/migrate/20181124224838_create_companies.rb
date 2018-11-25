class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :cnpj
      t.string :address
      t.string :neighborhood
      t.string :zipcode
      t.string :country
      t.string :longitude
      t.string :latidude
      t.references :category, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
