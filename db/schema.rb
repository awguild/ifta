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

ActiveRecord::Schema.define(version: 20150712144136) do

  create_table "conference_items", force: :cascade do |t|
    t.string   "name",                limit: 255
    t.string   "description",         limit: 255
    t.boolean  "multiple",                        default: false
    t.integer  "max",                 limit: 4
    t.integer  "conference_id",       limit: 4
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.boolean  "visibility"
    t.boolean  "manual_price"
    t.boolean  "user_comment"
    t.string   "user_comment_prompt", limit: 255
  end

  create_table "conferences", force: :cascade do |t|
    t.integer  "conference_year",             limit: 4
    t.decimal  "tax_rate",                                  precision: 10, scale: 2
    t.text     "proposal_acceptance_message", limit: 65535
    t.text     "proposal_wait_list_message",  limit: 65535
    t.text     "proposal_rejection_message",  limit: 65535
    t.text     "payment_recieved",            limit: 65535
    t.boolean  "active"
    t.datetime "created_at",                                                         null: false
    t.datetime "updated_at",                                                         null: false
    t.string   "proposal_acceptance_subject", limit: 255
    t.string   "proposal_wait_list_subject",  limit: 255
    t.string   "proposal_rejection_subject",  limit: 255
  end

  add_index "conferences", ["conference_year"], name: "index_conferences_on_conference_year", using: :btree

  create_table "countries", force: :cascade do |t|
    t.string  "name",     limit: 255
    t.integer "category", limit: 4
  end

  create_table "days", force: :cascade do |t|
    t.integer  "schedule_id", limit: 4
    t.string   "label",       limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.date     "day_date"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   limit: 4,     default: 0
    t.integer  "attempts",   limit: 4,     default: 0
    t.text     "handler",    limit: 65535
    t.text     "last_error", limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "discounts", force: :cascade do |t|
    t.string   "discount_key",  limit: 255
    t.string   "description",   limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "conference_id", limit: 4
  end

  add_index "discounts", ["conference_id"], name: "index_discounts_on_conference_id", using: :btree

  create_table "ifta_members", force: :cascade do |t|
    t.string "email", limit: 255
  end

  add_index "ifta_members", ["email"], name: "index_ifta_members_on_email", unique: true, using: :btree

  create_table "itineraries", force: :cascade do |t|
    t.integer  "conference_id", limit: 4
    t.integer  "user_id",       limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "discount_key",  limit: 255
  end

  create_table "line_items", force: :cascade do |t|
    t.integer  "conference_item_id", limit: 4
    t.integer  "itinerary_id",       limit: 4
    t.integer  "transaction_id",     limit: 4
    t.decimal  "price",                          precision: 10, scale: 2
    t.datetime "created_at",                                                              null: false
    t.datetime "updated_at",                                                              null: false
    t.boolean  "paid",                                                    default: false
    t.boolean  "untaxed",                                                 default: false
    t.string   "comment",            limit: 255
  end

  add_index "line_items", ["conference_item_id"], name: "index_line_items_on_conference_item_id", using: :btree
  add_index "line_items", ["itinerary_id"], name: "index_line_items_on_itinerary_id", using: :btree
  add_index "line_items", ["transaction_id"], name: "index_line_items_on_transaction_id", using: :btree

  create_table "multimedia", force: :cascade do |t|
    t.string "media_name", limit: 255
  end

  create_table "payments", force: :cascade do |t|
    t.integer  "transaction_id", limit: 4
    t.decimal  "amount",                       precision: 10, scale: 2, default: 0.0
    t.datetime "created_at",                                                          null: false
    t.datetime "updated_at",                                                          null: false
    t.text     "params",         limit: 65535
    t.boolean  "confirmed"
    t.string   "comments",       limit: 255,                            default: ""
  end

  create_table "presenters", force: :cascade do |t|
    t.string   "first_name",           limit: 255
    t.string   "last_name",            limit: 255
    t.string   "home_telephone",       limit: 255
    t.string   "work_telephone",       limit: 255
    t.string   "fax_number",           limit: 255
    t.string   "email",                limit: 255
    t.string   "affiliation_name",     limit: 255
    t.string   "affiliation_position", limit: 255
    t.string   "affiliation_location", limit: 255
    t.boolean  "registered"
    t.integer  "proposal_id",          limit: 4
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.boolean  "other_presentations"
    t.string   "other_emails",         limit: 255
  end

  create_table "prices", force: :cascade do |t|
    t.integer  "conference_item_id", limit: 4
    t.integer  "country_category",   limit: 4
    t.decimal  "amount",                         precision: 10, scale: 2
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
    t.string   "discount_key",       limit: 255
    t.boolean  "member"
  end

  add_index "prices", ["conference_item_id"], name: "index_prices_on_conference_item_id", using: :btree
  add_index "prices", ["country_category"], name: "index_prices_on_country_category", using: :btree
  add_index "prices", ["discount_key"], name: "index_prices_on_discount_key", using: :btree
  add_index "prices", ["member"], name: "index_prices_on_member", using: :btree

  create_table "proposals", force: :cascade do |t|
    t.string   "format",              limit: 255
    t.string   "category",            limit: 255
    t.string   "title",               limit: 255
    t.text     "short_description",   limit: 65535
    t.text     "long_description",    limit: 65535
    t.boolean  "student"
    t.boolean  "agree"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.integer  "itinerary_id",        limit: 4
    t.boolean  "no_equipment"
    t.boolean  "sound"
    t.boolean  "projector"
    t.boolean  "locked",                            default: false
    t.string   "status",              limit: 255
    t.string   "keywords",            limit: 255
    t.boolean  "language_english",                  default: true
    t.boolean  "language_spanish"
    t.boolean  "language_portuguese"
    t.boolean  "language_mandarin"
    t.boolean  "language_malay"
    t.integer  "relative_number",     limit: 4
    t.integer  "conference_id",       limit: 4
    t.integer  "user_id",             limit: 4
    t.datetime "date_accepted"
    t.datetime "date_emailed"
    t.datetime "invite_letter"
    t.text     "notes",               limit: 65535
  end

  add_index "proposals", ["conference_id"], name: "index_proposals_on_conference_id", using: :btree
  add_index "proposals", ["itinerary_id"], name: "index_proposals_on_itinerary_id", using: :btree
  add_index "proposals", ["user_id"], name: "index_proposals_on_user_id", using: :btree

  create_table "reviews", force: :cascade do |t|
    t.integer  "proposal_id", limit: 4
    t.string   "status",      limit: 255
    t.string   "comments",    limit: 255
    t.integer  "reviewer_id", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "reviews", ["proposal_id"], name: "index_reviews_on_proposal_id", using: :btree
  add_index "reviews", ["status"], name: "index_reviews_on_status", using: :btree

  create_table "rooms", force: :cascade do |t|
    t.integer  "schedule_id", limit: 4
    t.string   "label",       limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.boolean  "audio"
    t.boolean  "video"
  end

  create_table "schedules", force: :cascade do |t|
    t.integer  "conference_id", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "slots", force: :cascade do |t|
    t.integer  "time_block_id", limit: 4
    t.integer  "proposal_id",   limit: 4
    t.integer  "room_id",       limit: 4
    t.string   "code",          limit: 255
    t.text     "comments",      limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "time_blocks", force: :cascade do |t|
    t.integer  "schedule_id", limit: 4
    t.string   "code",        limit: 255
    t.string   "label",       limit: 255
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "time_slots", force: :cascade do |t|
    t.integer  "day_id",     limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.time     "start_time"
    t.time     "end_time"
    t.string   "code",       limit: 255
  end

  create_table "transactions", force: :cascade do |t|
    t.integer  "itinerary_id",   limit: 4
    t.datetime "created_at",                                                          null: false
    t.datetime "updated_at",                                                          null: false
    t.decimal  "tax",                        precision: 10, scale: 2
    t.boolean  "paid",                                                default: false
    t.string   "payment_method", limit: 255
  end

  add_index "transactions", ["itinerary_id"], name: "index_transactions_on_user_id", using: :btree
  add_index "transactions", ["paid"], name: "index_transactions_on_paid", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",         null: false
    t.string   "encrypted_password",     limit: 255, default: "",         null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
    t.string   "first_name",             limit: 255, default: ""
    t.string   "last_name",              limit: 255, default: ""
    t.string   "prefix",                 limit: 255
    t.string   "initial",                limit: 255
    t.string   "suffix",                 limit: 255
    t.string   "address",                limit: 255
    t.string   "city",                   limit: 255
    t.string   "state",                  limit: 255
    t.integer  "zip",                    limit: 4
    t.integer  "country_id",             limit: 4
    t.integer  "country_category",       limit: 4
    t.string   "phone",                  limit: 255
    t.string   "username",               limit: 255
    t.boolean  "member",                             default: false
    t.boolean  "student",                            default: false
    t.string   "role",                   limit: 255, default: "attendee"
    t.string   "fax_number",             limit: 255
    t.string   "ifta_member_email",      limit: 255
    t.string   "emergency_name",         limit: 255
    t.string   "emergency_relationship", limit: 255
    t.string   "emergency_telephone",    limit: 255
    t.string   "emergency_email",        limit: 255
    t.string   "nametag_name",           limit: 255
    t.string   "certificate_name",       limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  limit: 255,   null: false
    t.integer  "item_id",    limit: 4,     null: false
    t.string   "event",      limit: 255,   null: false
    t.string   "whodunnit",  limit: 255
    t.text     "object",     limit: 65535
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
