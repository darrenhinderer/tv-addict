# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090519035822) do

  create_table "facebook_users", :force => true do |t|
    t.integer  "uid",             :limit => 20, :null => false
    t.string   "session_key"
    t.string   "session_expires"
    t.datetime "last_access"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "facebook_users", ["uid"], :name => "index_facebook_users_on_uid", :unique => true

  create_table "responses", :force => true do |t|
    t.string   "status"
    t.integer  "facebook_user_id", :limit => 11
    t.integer  "show_id",          :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shows", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tvdb_id",    :limit => 11
    t.integer  "series_id",  :limit => 11
    t.string   "imdb_url"
    t.string   "banner_url"
    t.string   "overview"
  end

end
