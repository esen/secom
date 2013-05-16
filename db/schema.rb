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

ActiveRecord::Schema.define(:version => 20130512122953) do

  create_table "course_times", :force => true do |t|
    t.string   "starts_at"
    t.string   "ends_at"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "expenses", :force => true do |t|
    t.integer  "amount"
    t.integer  "teacher_id"
    t.integer  "hole_id"
    t.string   "note"
    t.date     "expended_at"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.integer  "level_id"
    t.date     "started_at"
    t.date     "finished_at"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.boolean  "active",      :default => false
    t.integer  "price",       :default => 0
  end

  create_table "holes", :force => true do |t|
    t.string   "name"
    t.string   "note"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "lessons", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "levels", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "ort_cheques", :force => true do |t|
    t.integer  "participant_id"
    t.integer  "exam_id"
    t.float    "mark"
    t.datetime "created_at"
  end

  create_table "ort_exam_types", :force => true do |t|
    t.string   "name"
    t.float    "cost"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "ort_exams", :force => true do |t|
    t.float    "cost"
    t.integer  "exam_type_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.date     "start_date"
  end

  create_table "ort_participants", :force => true do |t|
    t.string   "name"
    t.string   "encrypted_password"
    t.datetime "created_at"
  end

  create_table "ort_payments", :force => true do |t|
    t.integer  "participant_id"
    t.integer  "exam_id"
    t.float    "amount"
    t.datetime "created_at"
  end

  create_table "payment_dates", :force => true do |t|
    t.integer  "group_id"
    t.date     "payment_date"
    t.integer  "amount"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "payments", :force => true do |t|
    t.integer  "student_id"
    t.integer  "ort_participant_id"
    t.integer  "source_id"
    t.string   "note"
    t.integer  "amount"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.date     "payed_at"
  end

  create_table "rooms", :force => true do |t|
    t.string   "title"
    t.integer  "capacity"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sources", :force => true do |t|
    t.string   "name"
    t.string   "note"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "students", :force => true do |t|
    t.string   "name"
    t.string   "surname"
    t.date     "birth_date"
    t.string   "school"
    t.string   "address"
    t.string   "phone"
    t.integer  "group_id"
    t.integer  "discount",    :default => 0
    t.date     "started_at"
    t.date     "finished_at"
    t.boolean  "active",      :default => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "teachers", :force => true do |t|
    t.string   "name"
    t.string   "surname"
    t.string   "phone"
    t.string   "address"
    t.integer  "lesson_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "role"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.string   "username",            :default => "", :null => false
    t.string   "email",               :default => "", :null => false
    t.string   "encrypted_password",  :default => "", :null => false
    t.datetime "remember_created_at"
  end

end
