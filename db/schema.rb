# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150716090501) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comfy_cms_blocks", force: true do |t|
    t.string   "identifier",     null: false
    t.text     "content"
    t.integer  "blockable_id"
    t.string   "blockable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comfy_cms_blocks", ["blockable_id", "blockable_type"], name: "index_comfy_cms_blocks_on_blockable_id_and_blockable_type", using: :btree
  add_index "comfy_cms_blocks", ["identifier"], name: "index_comfy_cms_blocks_on_identifier", using: :btree

  create_table "comfy_cms_categories", force: true do |t|
    t.integer "site_id",          null: false
    t.string  "label",            null: false
    t.string  "categorized_type", null: false
  end

  add_index "comfy_cms_categories", ["site_id", "categorized_type", "label"], name: "index_cms_categories_on_site_id_and_cat_type_and_label", unique: true, using: :btree

  create_table "comfy_cms_categorizations", force: true do |t|
    t.integer "category_id",      null: false
    t.string  "categorized_type", null: false
    t.integer "categorized_id",   null: false
  end

  add_index "comfy_cms_categorizations", ["category_id", "categorized_type", "categorized_id"], name: "index_cms_categorizations_on_cat_id_and_catd_type_and_catd_id", unique: true, using: :btree

  create_table "comfy_cms_files", force: true do |t|
    t.integer  "site_id",                                    null: false
    t.integer  "block_id"
    t.string   "label",                                      null: false
    t.string   "file_file_name",                             null: false
    t.string   "file_content_type",                          null: false
    t.integer  "file_file_size",                             null: false
    t.string   "description",       limit: 2048
    t.integer  "position",                       default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comfy_cms_files", ["site_id", "block_id"], name: "index_comfy_cms_files_on_site_id_and_block_id", using: :btree
  add_index "comfy_cms_files", ["site_id", "file_file_name"], name: "index_comfy_cms_files_on_site_id_and_file_file_name", using: :btree
  add_index "comfy_cms_files", ["site_id", "label"], name: "index_comfy_cms_files_on_site_id_and_label", using: :btree
  add_index "comfy_cms_files", ["site_id", "position"], name: "index_comfy_cms_files_on_site_id_and_position", using: :btree

  create_table "comfy_cms_layouts", force: true do |t|
    t.integer  "site_id",                    null: false
    t.integer  "parent_id"
    t.string   "app_layout"
    t.string   "label",                      null: false
    t.string   "identifier",                 null: false
    t.text     "content"
    t.text     "css"
    t.text     "js"
    t.integer  "position",   default: 0,     null: false
    t.boolean  "is_shared",  default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comfy_cms_layouts", ["parent_id", "position"], name: "index_comfy_cms_layouts_on_parent_id_and_position", using: :btree
  add_index "comfy_cms_layouts", ["site_id", "identifier"], name: "index_comfy_cms_layouts_on_site_id_and_identifier", unique: true, using: :btree

  create_table "comfy_cms_pages", force: true do |t|
    t.integer  "site_id",                        null: false
    t.integer  "layout_id"
    t.integer  "parent_id"
    t.integer  "target_page_id"
    t.string   "label",                          null: false
    t.string   "slug"
    t.string   "full_path",                      null: false
    t.text     "content_cache"
    t.integer  "position",       default: 0,     null: false
    t.integer  "children_count", default: 0,     null: false
    t.boolean  "is_published",   default: true,  null: false
    t.boolean  "is_shared",      default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comfy_cms_pages", ["parent_id", "position"], name: "index_comfy_cms_pages_on_parent_id_and_position", using: :btree
  add_index "comfy_cms_pages", ["site_id", "full_path"], name: "index_comfy_cms_pages_on_site_id_and_full_path", using: :btree

  create_table "comfy_cms_revisions", force: true do |t|
    t.string   "record_type", null: false
    t.integer  "record_id",   null: false
    t.text     "data"
    t.datetime "created_at"
  end

  add_index "comfy_cms_revisions", ["record_type", "record_id", "created_at"], name: "index_cms_revisions_on_rtype_and_rid_and_created_at", using: :btree

  create_table "comfy_cms_sites", force: true do |t|
    t.string  "label",                       null: false
    t.string  "identifier",                  null: false
    t.string  "hostname",                    null: false
    t.string  "path"
    t.string  "locale",      default: "en",  null: false
    t.boolean "is_mirrored", default: false, null: false
  end

  add_index "comfy_cms_sites", ["hostname"], name: "index_comfy_cms_sites_on_hostname", using: :btree
  add_index "comfy_cms_sites", ["is_mirrored"], name: "index_comfy_cms_sites_on_is_mirrored", using: :btree

  create_table "comfy_cms_snippets", force: true do |t|
    t.integer  "site_id",                    null: false
    t.string   "label",                      null: false
    t.string   "identifier",                 null: false
    t.text     "content"
    t.integer  "position",   default: 0,     null: false
    t.boolean  "is_shared",  default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comfy_cms_snippets", ["site_id", "identifier"], name: "index_comfy_cms_snippets_on_site_id_and_identifier", unique: true, using: :btree
  add_index "comfy_cms_snippets", ["site_id", "position"], name: "index_comfy_cms_snippets_on_site_id_and_position", using: :btree

  create_table "distributors", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "distributors", ["deleted_at"], name: "index_distributors_on_deleted_at", using: :btree
  add_index "distributors", ["user_id"], name: "index_distributors_on_user_id", using: :btree

  create_table "document_types", force: true do |t|
    t.string   "name"
    t.boolean  "distr"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.integer  "tab"
  end

  add_index "document_types", ["deleted_at"], name: "index_document_types_on_deleted_at", using: :btree

  create_table "documents", force: true do |t|
    t.string   "file"
    t.integer  "order_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "document_type_id"
    t.integer  "user_id"
    t.date     "doc_date"
    t.string   "doc_no"
    t.text     "memo"
    t.decimal  "summa",            precision: 8, scale: 2
  end

  add_index "documents", ["document_type_id"], name: "index_documents_on_document_type_id", using: :btree
  add_index "documents", ["order_id"], name: "index_documents_on_order_id", using: :btree
  add_index "documents", ["user_id"], name: "index_documents_on_user_id", using: :btree

  create_table "messages", force: true do |t|
    t.string   "subject"
    t.text     "body"
    t.string   "attachment"
    t.integer  "user_id"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "deleted",      default: false
    t.string   "content_type"
    t.integer  "file_size"
  end

  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "nomenclature_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nomenclatures", force: true do |t|
    t.string   "name"
    t.text     "full_name"
    t.string   "partner_number"
    t.integer  "nomenclature_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.boolean  "archived",             default: false
  end

  add_index "nomenclatures", ["deleted_at"], name: "index_nomenclatures_on_deleted_at", using: :btree
  add_index "nomenclatures", ["name"], name: "index_nomenclatures_on_name", using: :btree
  add_index "nomenclatures", ["nomenclature_type_id"], name: "index_nomenclatures_on_nomenclature_type_id", using: :btree
  add_index "nomenclatures", ["partner_number"], name: "index_nomenclatures_on_partner_number", using: :btree

  create_table "order_items", force: true do |t|
    t.integer  "order_id"
    t.integer  "nomenclature_id"
    t.string   "partner_number"
    t.integer  "quantity"
    t.decimal  "price",           precision: 8, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "order_items", ["nomenclature_id"], name: "index_order_items_on_nomenclature_id", using: :btree
  add_index "order_items", ["order_id"], name: "index_order_items_on_order_id", using: :btree

  create_table "orders", force: true do |t|
    t.integer  "distributor_id"
    t.integer  "user_id"
    t.text     "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.string   "state"
    t.boolean  "docs",           default: false
  end

  add_index "orders", ["deleted_at"], name: "index_orders_on_deleted_at", using: :btree
  add_index "orders", ["distributor_id"], name: "index_orders_on_distributor_id", using: :btree
  add_index "orders", ["state"], name: "index_orders_on_state", using: :btree
  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "posts", force: true do |t|
    t.string   "name"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "prices", force: true do |t|
    t.integer  "distributor_id"
    t.integer  "nomenclature_id"
    t.decimal  "price",           precision: 8, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "prices", ["deleted_at"], name: "index_prices_on_deleted_at", using: :btree
  add_index "prices", ["distributor_id"], name: "index_prices_on_distributor_id", using: :btree
  add_index "prices", ["nomenclature_id"], name: "index_prices_on_nomenclature_id", using: :btree

  create_table "recipients", force: true do |t|
    t.integer  "message_id"
    t.integer  "user_id"
    t.boolean  "readed",     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "deleted",    default: false
  end

  add_index "recipients", ["message_id"], name: "index_recipients_on_message_id", using: :btree
  add_index "recipients", ["user_id"], name: "index_recipients_on_user_id", using: :btree

  create_table "revises", force: true do |t|
    t.date     "date_begin"
    t.date     "date_end"
    t.text     "memo"
    t.integer  "distributor_id"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file"
    t.string   "state"
  end

  add_index "revises", ["distributor_id"], name: "index_revises_on_distributor_id", using: :btree

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "roles", ["deleted_at"], name: "index_roles_on_deleted_at", using: :btree
  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "failed_attempts",        default: 0
    t.string   "unlock_token"
    t.datetime "locked_at"
  end

  add_index "users", ["deleted_at"], name: "index_users_on_deleted_at", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

  create_table "versions", force: true do |t|
    t.string   "item_type",      null: false
    t.integer  "item_id",        null: false
    t.string   "event",          null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.text     "object_changes"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
