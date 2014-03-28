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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140328210129) do

  create_table "conference_items", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.boolean  "multiple",            :default => false
    t.integer  "max"
    t.integer  "conference_id"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.boolean  "visibility"
    t.boolean  "manual_price"
    t.boolean  "user_comment"
    t.string   "user_comment_prompt"
  end

  create_table "conferences", :force => true do |t|
    t.integer  "conference_year"
    t.decimal  "tax_rate",                    :precision => 10, :scale => 2
    t.text     "proposal_acceptance_message"
    t.text     "proposal_wait_list_message"
    t.text     "proposal_rejection_message"
    t.text     "payment_recieved"
    t.boolean  "active"
    t.datetime "created_at",                                                 :null => false
    t.datetime "updated_at",                                                 :null => false
    t.string   "proposal_acceptance_subject"
    t.string   "proposal_wait_list_subject"
    t.string   "proposal_rejection_subject"
  end

  create_table "countries", :force => true do |t|
    t.string  "name"
    t.integer "category"
  end

  create_table "days", :force => true do |t|
    t.integer  "schedule_id"
    t.string   "label"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.date     "day_date"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "discounts", :force => true do |t|
    t.string   "discount_key"
    t.string   "description"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "conference_id"
  end

  add_index "discounts", ["conference_id"], :name => "index_discounts_on_conference_id"

  create_table "ifta_members", :force => true do |t|
    t.string "email"
  end

  add_index "ifta_members", ["email"], :name => "index_ifta_members_on_email", :unique => true

  create_table "itineraries", :force => true do |t|
    t.integer  "conference_id"
    t.integer  "user_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "discount_key"
  end

  create_table "line_items", :force => true do |t|
    t.integer  "conference_item_id"
    t.integer  "itinerary_id"
    t.integer  "transaction_id"
    t.decimal  "price",              :precision => 10, :scale => 2
    t.datetime "created_at",                                                           :null => false
    t.datetime "updated_at",                                                           :null => false
    t.boolean  "paid",                                              :default => false
    t.boolean  "untaxed",                                           :default => false
    t.string   "comment"
  end

  add_index "line_items", ["conference_item_id"], :name => "index_line_items_on_conference_item_id"
  add_index "line_items", ["itinerary_id"], :name => "index_line_items_on_itinerary_id"
  add_index "line_items", ["transaction_id"], :name => "index_line_items_on_transaction_id"

  create_table "multimedia", :force => true do |t|
    t.string "media_name"
  end

  create_table "payments", :force => true do |t|
    t.integer  "transaction_id"
    t.integer  "amount",         :default => 0
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.text     "params"
    t.boolean  "confirmed"
    t.string   "comments",       :default => ""
  end

  create_table "presenters", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "home_telephone"
    t.string   "work_telephone"
    t.string   "fax_number"
    t.string   "email"
    t.string   "affiliation_name"
    t.string   "affiliation_position"
    t.string   "affiliation_location"
    t.boolean  "registered"
    t.integer  "proposal_id"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.boolean  "other_presentations"
    t.string   "other_emails"
  end

  create_table "prices", :force => true do |t|
    t.integer  "conference_item_id"
    t.integer  "country_category"
    t.decimal  "amount",             :precision => 10, :scale => 2
    t.datetime "created_at",                                        :null => false
    t.datetime "updated_at",                                        :null => false
    t.string   "discount_key"
    t.boolean  "member"
  end

  add_index "prices", ["conference_item_id"], :name => "index_prices_on_conference_item_id"
  add_index "prices", ["country_category"], :name => "index_prices_on_country_category"
  add_index "prices", ["discount_key"], :name => "index_prices_on_discount_key"
  add_index "prices", ["member"], :name => "index_prices_on_member"

  create_table "proposals", :force => true do |t|
    t.string   "format"
    t.string   "category"
    t.string   "title"
    t.text     "short_description"
    t.text     "long_description"
    t.boolean  "student"
    t.boolean  "agree"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "itinerary_id"
    t.boolean  "no_equipment"
    t.boolean  "sound"
    t.boolean  "projector"
    t.boolean  "locked",              :default => false
    t.string   "status"
    t.string   "keywords"
    t.boolean  "language_english",    :default => true
    t.boolean  "language_spanish"
    t.boolean  "language_portuguese"
    t.boolean  "language_mandarin"
    t.boolean  "language_malay"
  end

  add_index "proposals", ["itinerary_id"], :name => "index_proposals_on_itinerary_id"

  create_table "reviews", :force => true do |t|
    t.integer  "proposal_id"
    t.string   "status"
    t.string   "comments"
    t.integer  "reviewer_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "reviews", ["proposal_id"], :name => "index_reviews_on_proposal_id"
  add_index "reviews", ["status"], :name => "index_reviews_on_status"

  create_table "rooms", :force => true do |t|
    t.integer  "schedule_id"
    t.string   "label"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "schedules", :force => true do |t|
    t.integer  "conference_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "slots", :force => true do |t|
    t.integer  "time_slot_id"
    t.integer  "proposal_id"
    t.integer  "room_id"
    t.string   "code"
    t.text     "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "time_slots", :force => true do |t|
    t.integer  "day_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.time     "start_time"
    t.time     "end_time"
    t.string   "code"
  end

  create_table "transactions", :force => true do |t|
    t.integer  "itinerary_id"
    t.datetime "created_at",                                                       :null => false
    t.datetime "updated_at",                                                       :null => false
    t.decimal  "tax",            :precision => 10, :scale => 2
    t.boolean  "paid",                                          :default => false
    t.string   "payment_method"
  end

  add_index "transactions", ["itinerary_id"], :name => "index_transactions_on_user_id"
  add_index "transactions", ["paid"], :name => "index_transactions_on_paid"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",         :null => false
    t.string   "encrypted_password",     :default => "",         :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
    t.string   "first_name",             :default => ""
    t.string   "last_name",              :default => ""
    t.string   "prefix"
    t.string   "initial"
    t.string   "suffix"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.integer  "zip"
    t.integer  "country_id"
    t.integer  "country_category"
    t.string   "phone"
    t.string   "username"
    t.boolean  "member",                 :default => false
    t.boolean  "student",                :default => false
    t.string   "role",                   :default => "attendee"
    t.string   "fax_number"
    t.string   "ifta_member_email"
    t.string   "emergency_name"
    t.string   "emergency_relationship"
    t.string   "emergency_telephone"
    t.string   "emergency_email"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

end
