class ChangeColumnNameOnAccommodation < ActiveRecord::Migration[6.0]
  def change
    rename_column :accommodations, :square_metes, :square_meters
  end
end
