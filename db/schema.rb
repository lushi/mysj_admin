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

ActiveRecord::Schema.define(:version => 20130417163841) do

  create_table "payment_plan_choices", :force => true do |t|
    t.integer  "payment_plan_id"
    t.integer  "student_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "payment_plans", :force => true do |t|
    t.string   "name"
    t.integer  "amount_cents"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "currency"
  end

  create_table "payments", :force => true do |t|
    t.integer  "student_id"
    t.integer  "amount_cents"
    t.string   "currency"
    t.string   "method"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "for"
    t.string   "memo"
  end

  add_index "payments", ["student_id", "created_at"], :name => "index_payments_on_student_id_and_created_at"

  create_table "students", :force => true do |t|
    t.string   "surname"
    t.string   "email"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.string   "password_digest"
    t.string   "given_name"
    t.string   "auth_token"
    t.string   "sex"
    t.date     "date_of_birth"
    t.string   "occupation"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.string   "country"
    t.string   "shirt_size"
    t.string   "pants_size"
    t.string   "shoe_size"
    t.string   "status",          :default => "student"
    t.integer  "generation",      :default => 1
    t.string   "concentration",   :default => "wing chun"
    t.boolean  "enrolled_now",    :default => true
    t.string   "home_phone"
    t.string   "cell_phone"
    t.boolean  "admin",           :default => false
  end

  add_index "students", ["auth_token"], :name => "index_students_on_auth_token"
  add_index "students", ["email"], :name => "index_students_on_email", :unique => true

end
