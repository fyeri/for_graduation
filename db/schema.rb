# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2024_02_22_091203) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "item_labels", force: :cascade do |t|
    t.bigint "item_id", null: false
    t.bigint "label_id", null: false
    t.string "reason"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["item_id"], name: "index_item_labels_on_item_id"
    t.index ["label_id"], name: "index_item_labels_on_label_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name", null: false
    t.string "character", null: false
    t.integer "category", null: false
    t.date "purchased_on"
    t.string "image"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name", "character"], name: "index_items_on_name_and_character"
    t.index ["user_id"], name: "index_items_on_user_id"
  end

  create_table "labels", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_labels_on_name"
    t.index ["user_id"], name: "index_labels_on_user_id"
  end

  create_table "owned_items", force: :cascade do |t|
    t.integer "quantity", null: false
    t.text "remark"
    t.bigint "item_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["item_id"], name: "index_owned_items_on_item_id"
    t.index ["user_id"], name: "index_owned_items_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wanted_items", force: :cascade do |t|
    t.integer "quantity", null: false
    t.text "remark"
    t.bigint "item_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["item_id"], name: "index_wanted_items_on_item_id"
    t.index ["user_id"], name: "index_wanted_items_on_user_id"
  end

  add_foreign_key "item_labels", "items"
  add_foreign_key "item_labels", "labels"
end
