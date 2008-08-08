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

ActiveRecord::Schema.define do

  create_table "admins", :force => true do |t|
    t.string   "login"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.string   "value"
    t.integer  "position",   :limit => 11, :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "job_applicants", :force => true do |t|
    t.integer  "job_id",       :limit => 11
    t.string   "name"
    t.string   "email"
    t.string   "message"
    t.string   "ip"
    t.string   "content_type"
    t.string   "filename"
    t.string   "thumbnail"
    t.integer  "size",         :limit => 11
    t.integer  "width",        :limit => 11
    t.integer  "height",       :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "job_hunters", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "job_hunters_job_params", :force => true do |t|
    t.integer  "job_hunter_id", :limit => 11
    t.integer  "job_param_id",  :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "job_param_categories", :force => true do |t|
    t.string   "name"
    t.integer  "position",   :limit => 11, :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "job_params", :force => true do |t|
    t.string   "job_param_category_id"
    t.string   "param_value"
    t.integer  "position",              :limit => 11, :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "job_types", :force => true do |t|
    t.string   "name"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "jobs", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "company"
    t.string   "url"
    t.string   "apply"
    t.boolean  "is_temp"
    t.boolean  "is_active",                          :default => false
    t.string   "outside_location"
    t.string   "poster_email"
    t.boolean  "apply_online"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "location_id",          :limit => 11
    t.integer  "job_type_id",          :limit => 11
    t.integer  "category_id",          :limit => 11
    t.boolean  "verified",                           :default => false
    t.boolean  "confirmed",                          :default => false
    t.text     "description_html"
    t.string   "formatting_type"
    t.integer  "job_applicants_count", :limit => 11, :default => 0
    t.integer  "view_count",           :limit => 11, :default => 0
    t.integer  "report_count",         :limit => 11, :default => 0
  end

  create_table "locations", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", :force => true do |t|
    t.string   "url"
    t.string   "page_title"
    t.text     "keywords"
    t.text     "description"
    t.string   "title"
    t.text     "content"
    t.boolean  "has_form"
    t.text     "form_message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
