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

ActiveRecord::Schema.define(version: 20160104163542) do

  create_table "admin_admin_users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password"
    t.string   "reset_password_token"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admin_general_pages", force: true do |t|
    t.string   "page_name"
    t.string   "page_title"
    t.text     "page_content", limit: 2147483647
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admin_help_centers", force: true do |t|
    t.text     "question"
    t.text     "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admin_qualifications", force: true do |t|
    t.string   "qualification"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admin_skills", force: true do |t|
    t.string   "skill"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admin_staff_plans", force: true do |t|
    t.string   "plan_name"
    t.integer  "no_of_staff"
    t.integer  "plan_price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "company_requests", force: true do |t|
    t.string   "name"
    t.integer  "amount"
    t.integer  "total_emp"
    t.integer  "selected_emp"
    t.integer  "total_days"
    t.text     "additional"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "request_by"
    t.integer  "request_to"
    t.integer  "is_rejected"
    t.integer  "is_approved"
    t.integer  "is_paid"
    t.string   "user_emailTo"
    t.string   "user_emailBy"
  end

  create_table "company_staffs", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.integer  "company_id"
    t.string   "skills"
    t.string   "availability"
    t.boolean  "is_private"
    t.string   "qualification"
    t.string   "experience"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "location"
    t.string   "availability_to"
    t.string   "availability_from"
  end

  add_index "company_staffs", ["company_id"], name: "fk_staff", using: :btree

  create_table "favourite_searches", force: true do |t|
    t.string   "skills"
    t.string   "qualification"
    t.string   "experience"
    t.string   "availability"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscription_plans", force: true do |t|
    t.string   "plan_name"
    t.string   "plan_price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "plan_type"
    t.integer  "total_profiles"
  end

  create_table "user_payments", force: true do |t|
    t.string   "payment_method"
    t.string   "payment_status"
    t.string   "user_id"
    t.text     "payment_json"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password"
    t.integer  "plan_id"
    t.integer  "user_type"
    t.string   "reset_password_token"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["plan_id"], name: "fk_plan", using: :btree

  create_table "users_payment_histories", force: true do |t|
    t.integer  "plan_id"
    t.integer  "user_id"
    t.datetime "purchased_on"
    t.datetime "expired_on"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "plan_type"
    t.string   "plan_name"
  end

  create_table "users_staff_plans", force: true do |t|
    t.integer  "user_id"
    t.integer  "plan_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "no_of_profiles", default: 0
  end

  add_index "users_staff_plans", ["user_id"], name: "fk_user", using: :btree

end
