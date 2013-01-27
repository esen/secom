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

ActiveRecord::Schema.define(:version => 20130127075205) do

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
    t.string   "password"
    t.datetime "created_at"
  end

  create_table "ort_payments", :force => true do |t|
    t.integer  "participant_id"
    t.integer  "exam_id"
    t.float    "amount"
    t.datetime "created_at"
  end

end
