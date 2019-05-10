class AddCanceledAtToLeasedRequest < ActiveRecord::Migration[6.0]
  def change
    add_column :leased_requests, :canceled_at, :date
  end
end
