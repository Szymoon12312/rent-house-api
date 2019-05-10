class CreateAccommodationLeaseds < ActiveRecord::Migration[6.0]
  def change
    create_table :accommodation_leaseds do |t|
      t.references :accommodation, foreign_key: true
      t.references :renter_group, foreign_key: { to_table: :groups }
      t.date :leased_from
      t.date :leased_to
      t.references :price, foreign_key: true
      t.references :renter, foreign_key: { to_table: :users }
      t.integer :discount
      t.integer :fee
      t.integer :leased_price

      t.timestamps
    end
  end
end
