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

ActiveRecord::Schema.define(version: 20140810185103) do

  create_table "plans", force: true do |t|
    t.string  "name",             null: false
    t.integer "rate", default: 0, null: false
  end

  create_table "stripe_events", force: true do |t|
    t.string   "stripe_id",   null: false
    t.string   "stripe_type", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "stripe_events", ["stripe_id"], name: "index_stripe_events_on_stripe_id", unique: true

  create_table "subscriptions", force: true do |t|
    t.integer  "user_id",               null: false
    t.string   "billing_email",         null: false
    t.string   "card_last4"
    t.string   "card_type"
    t.date     "card_expiration"
    t.string   "stripe_id"
    t.date     "free_trial_expiration"
    t.integer  "plan_id",               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id"

  create_table "users", force: true do |t|
    t.string   "first_name",             default: "", null: false
    t.string   "last_name",              default: "", null: false
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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
