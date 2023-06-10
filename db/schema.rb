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

ActiveRecord::Schema.define(version: 2023_06_10_210129) do

  create_table "conference_items", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.boolean "multiple", default: false
    t.integer "max"
    t.integer "conference_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "visibility"
    t.boolean "manual_price"
    t.boolean "user_comment"
    t.string "user_comment_prompt"
  end

  create_table "conferences", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "conference_year"
    t.decimal "tax_rate", precision: 10, scale: 2
    t.text "proposal_acceptance_message"
    t.text "proposal_wait_list_message"
    t.text "proposal_rejection_message"
    t.text "payment_recieved"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "proposal_acceptance_subject"
    t.string "proposal_wait_list_subject"
    t.string "proposal_rejection_subject"
    t.index ["conference_year"], name: "index_conferences_on_conference_year"
  end

  create_table "countries", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name"
    t.integer "category"
  end

  create_table "delayed_jobs", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "priority", default: 0
    t.integer "attempts", default: 0
    t.text "handler"
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "discounts", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "discount_key"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "conference_id"
    t.index ["conference_id"], name: "index_discounts_on_conference_id"
  end

  create_table "ifta_members", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "email"
    t.index ["email"], name: "index_ifta_members_on_email", unique: true
  end

  create_table "itineraries", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "conference_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "discount_key"
  end

  create_table "line_items", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "conference_item_id"
    t.integer "itinerary_id"
    t.integer "transaction_id"
    t.decimal "price", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "paid", default: false
    t.boolean "untaxed", default: false
    t.string "comment"
    t.index ["conference_item_id"], name: "index_line_items_on_conference_item_id"
    t.index ["itinerary_id"], name: "index_line_items_on_itinerary_id"
    t.index ["transaction_id"], name: "index_line_items_on_transaction_id"
  end

  create_table "multimedia", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "media_name"
  end

  create_table "payments", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "transaction_id"
    t.decimal "amount", precision: 10, scale: 2, default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "params"
    t.boolean "confirmed"
    t.string "comments", default: ""
  end

  create_table "presenters", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "home_telephone"
    t.string "work_telephone"
    t.string "fax_number"
    t.string "email"
    t.string "affiliation_name"
    t.string "affiliation_position"
    t.string "affiliation_location"
    t.boolean "registered"
    t.integer "proposal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "other_presentations"
    t.string "other_emails"
    t.integer "country_id"
    t.string "highest_degree"
    t.string "graduating_institution"
    t.text "qualifications"
    t.index ["country_id"], name: "index_presenters_on_country_id"
  end

  create_table "prices", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "conference_item_id"
    t.integer "country_category"
    t.decimal "amount", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "discount_key"
    t.boolean "member"
    t.index ["conference_item_id"], name: "index_prices_on_conference_item_id"
    t.index ["country_category"], name: "index_prices_on_country_category"
    t.index ["discount_key"], name: "index_prices_on_discount_key"
    t.index ["member"], name: "index_prices_on_member"
  end

  create_table "proposals", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "format"
    t.string "category"
    t.string "title"
    t.text "short_description"
    t.text "long_description"
    t.boolean "student"
    t.boolean "agree"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "itinerary_id"
    t.boolean "no_equipment"
    t.boolean "sound"
    t.boolean "projector"
    t.boolean "locked", default: false
    t.string "status"
    t.string "keywords"
    t.boolean "language_english", default: true
    t.boolean "language_spanish"
    t.boolean "language_portuguese"
    t.boolean "language_mandarin"
    t.boolean "language_japanese"
    t.boolean "language_korean"
    t.boolean "language_malay"
    t.integer "relative_number"
    t.integer "conference_id"
    t.integer "user_id"
    t.datetime "date_accepted"
    t.datetime "date_emailed"
    t.datetime "invite_letter"
    t.text "notes"
    t.boolean "language_thai"
    t.text "learning_objective"
    t.string "title_non_english"
    t.text "short_description_non_english"
    t.text "long_description_non_english"
    t.index ["conference_id"], name: "index_proposals_on_conference_id"
    t.index ["itinerary_id"], name: "index_proposals_on_itinerary_id"
    t.index ["user_id"], name: "index_proposals_on_user_id"
  end

  create_table "reviews", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "proposal_id"
    t.string "status"
    t.string "comments"
    t.integer "reviewer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["proposal_id"], name: "index_reviews_on_proposal_id"
    t.index ["status"], name: "index_reviews_on_status"
  end

  create_table "rooms", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "schedule_id"
    t.string "label"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "audio"
    t.boolean "video"
  end

  create_table "schedules", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "conference_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "slots", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "time_block_id"
    t.integer "proposal_id"
    t.integer "room_id"
    t.string "code"
    t.text "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "time_blocks", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "schedule_id"
    t.string "code"
    t.string "label"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "itinerary_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "tax", precision: 10, scale: 2
    t.boolean "paid", default: false
    t.string "payment_method"
    t.index ["itinerary_id"], name: "index_transactions_on_user_id"
    t.index ["paid"], name: "index_transactions_on_paid"
  end

  create_table "users", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name", default: ""
    t.string "last_name", default: ""
    t.string "prefix"
    t.string "initial"
    t.string "suffix"
    t.string "address"
    t.string "city"
    t.string "state"
    t.integer "zip"
    t.integer "country_id"
    t.integer "country_category"
    t.string "phone"
    t.string "username"
    t.boolean "member", default: false
    t.boolean "student", default: false
    t.string "role", default: "attendee"
    t.string "fax_number"
    t.string "ifta_member_email"
    t.string "emergency_name"
    t.string "emergency_relationship"
    t.string "emergency_telephone"
    t.string "emergency_email"
    t.string "nametag_name"
    t.string "certificate_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "versions", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "item_type", null: false
    t.integer "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

end
