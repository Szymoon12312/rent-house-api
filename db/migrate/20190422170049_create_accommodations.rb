class CreateAccommodations < ActiveRecord::Migration[6.0]
  def change
    create_table :accommodations do |t|
      t.string :name
      t.text :description
      t.boolean :available
      t.float :square_metes
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
