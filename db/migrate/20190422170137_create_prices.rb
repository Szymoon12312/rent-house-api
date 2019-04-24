class CreatePrices < ActiveRecord::Migration[6.0]
  def change
    create_table :prices do |t|
      t.string :name
      t.integer :value
      t.date :valid_from
      t.date :valid_to
      t.references :accommodation, foreign_key: true

      t.timestamps
    end
  end
end
