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

ActiveRecord::Schema.define(:version => 20120626210603) do

  create_table "sms_message_templates", :force => true do |t|
    t.boolean  "system",                    :null => false
    t.string   "name",       :limit => 64
    t.string   "desc",       :limit => 64
    t.string   "body",       :limit => 200, :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "sms_message_templates", ["desc"], :name => "index_sms_message_templates_on_desc", :unique => true
  add_index "sms_message_templates", ["name"], :name => "index_sms_message_templates_on_name", :unique => true
  add_index "sms_message_templates", ["system"], :name => "index_sms_message_templates_on_system"

  create_table "sms_messages", :force => true do |t|
    t.integer  "subscriber_id"
    t.integer  "parent_id"
    t.integer  "status_code",                  :null => false
    t.string   "phone_number",  :limit => 10,  :null => false
    t.string   "body",          :limit => 160
    t.string   "sid",           :limit => 34
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "sms_messages", ["phone_number"], :name => "index_sms_messages_on_phone_number"
  add_index "sms_messages", ["sid"], :name => "index_sms_messages_on_sid"
  add_index "sms_messages", ["status_code"], :name => "index_sms_messages_on_status_code"

  create_table "sms_subscribers", :force => true do |t|
    t.boolean  "active",                     :default => false, :null => false
    t.string   "phone_number", :limit => 10,                    :null => false
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
  end

  add_index "sms_subscribers", ["active"], :name => "index_sms_subscribers_on_active"
  add_index "sms_subscribers", ["phone_number"], :name => "index_sms_subscribers_on_phone_number", :unique => true

end
