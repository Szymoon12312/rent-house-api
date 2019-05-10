class CreateLeasedRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :leased_requests do |t|
      t.references :group, foreign_key: true
      t.references :user, foreign_key: true
      t.references :accommodation, foreign_key: true
      t.date :rejected_at
      t.date :accepted_at
      t.string :status, default: "pending"

      t.timestamps
    end
  end
end
