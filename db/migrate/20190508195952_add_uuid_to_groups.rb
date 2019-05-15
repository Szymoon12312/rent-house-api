class AddUuidToGroups < ActiveRecord::Migration[6.0]
  def change
    enable_extension 'uuid-ossp'
    add_column :groups, :uuid, :uuid, default: "uuid_generate_v4()", null: false
  end
end
