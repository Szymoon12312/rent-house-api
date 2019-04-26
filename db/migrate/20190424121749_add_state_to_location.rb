class AddStateToLocation < ActiveRecord::Migration[6.0]
  def change
    add_column :locations, :state, :string
  end
end
