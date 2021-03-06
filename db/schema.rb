# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_12_02_102247) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "accommodation_leaseds", force: :cascade do |t|
    t.bigint "accommodation_id"
    t.bigint "renter_group_id"
    t.date "leased_from"
    t.date "leased_to"
    t.bigint "price_id"
    t.bigint "renter_id"
    t.integer "discount"
    t.integer "fee"
    t.integer "leased_price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["accommodation_id"], name: "index_accommodation_leaseds_on_accommodation_id"
    t.index ["price_id"], name: "index_accommodation_leaseds_on_price_id"
    t.index ["renter_group_id"], name: "index_accommodation_leaseds_on_renter_group_id"
    t.index ["renter_id"], name: "index_accommodation_leaseds_on_renter_id"
  end

  create_table "accommodation_properties", force: :cascade do |t|
    t.bigint "accommodation_id"
    t.integer "kitchen"
    t.integer "bathrooms"
    t.integer "bedrooms"
    t.integer "terrace"
    t.integer "balcony"
    t.boolean "furnished"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["accommodation_id"], name: "index_accommodation_properties_on_accommodation_id"
  end

  create_table "accommodation_types", force: :cascade do |t|
    t.string "name"
    t.bigint "accommodation_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["accommodation_id"], name: "index_accommodation_types_on_accommodation_id"
  end

  create_table "accommodations", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.boolean "available", default: true
    t.float "square_meters"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_accommodations_on_user_id"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "uuid", default: -> { "uuid_generate_v4()" }, null: false
  end

  create_table "leased_requests", force: :cascade do |t|
    t.bigint "group_id"
    t.bigint "user_id"
    t.bigint "accommodation_id"
    t.date "rejected_at"
    t.date "accepted_at"
    t.string "status", default: "pending"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "canceled_at"
    t.index ["accommodation_id"], name: "index_leased_requests_on_accommodation_id"
    t.index ["group_id"], name: "index_leased_requests_on_group_id"
    t.index ["user_id"], name: "index_leased_requests_on_user_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "country"
    t.string "city"
    t.string "street"
    t.integer "property_number"
    t.float "longitude"
    t.float "latitude"
    t.bigint "accommodation_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "state"
    t.index ["accommodation_id"], name: "index_locations_on_accommodation_id"
  end

  create_table "prices", force: :cascade do |t|
    t.string "name"
    t.integer "value"
    t.date "valid_from"
    t.date "valid_to"
    t.bigint "accommodation_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["accommodation_id"], name: "index_prices_on_accommodation_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "user_groups", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "group_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email", default: "", null: false
    t.string "phone_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "surname"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  add_foreign_key "accommodation_leaseds", "accommodations"
  add_foreign_key "accommodation_leaseds", "groups", column: "renter_group_id"
  add_foreign_key "accommodation_leaseds", "prices"
  add_foreign_key "accommodation_leaseds", "users", column: "renter_id"
  add_foreign_key "accommodation_properties", "accommodations"
  add_foreign_key "accommodation_types", "accommodations"
  add_foreign_key "accommodations", "users"
  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "leased_requests", "accommodations"
  add_foreign_key "leased_requests", "groups"
  add_foreign_key "leased_requests", "users"
  add_foreign_key "locations", "accommodations"
  add_foreign_key "prices", "accommodations"
end
