class CreateAccommodationProperties < ActiveRecord::Migration[6.0]
  def change
    create_table :accommodation_properties do |t|
      t.references :accommodation, foreign_key: true
      t.integer :kitchen
      t.integer :bathrooms
      t.integer :bedrooms
      t.integer :terrace
      t.integer :balcony
      t.boolean :furnished

      t.timestamps
    end
  end
end
