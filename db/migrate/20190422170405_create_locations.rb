class CreateLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :locations do |t|
      t.string :country
      t.string :city
      t.string :street
      t.integer :property_number
      t.float :longitude
      t.float :latitude
      t.references :accommodation, foreign_key: true

      t.timestamps
    end
  end
end
