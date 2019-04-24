class CreateAccommodationTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :accommodation_types do |t|
      t.string :name
      t.references :accommodation, foreign_key: true

      t.timestamps
    end
  end
end
