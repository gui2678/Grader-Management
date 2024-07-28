# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_07_28_010602) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "approvals", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "approved_by"
    t.datetime "approved_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_approvals_on_user_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "course_number"
    t.string "course_name"
    t.text "course_description"
    t.integer "credits"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "term"
    t.date "effective_date"
    t.string "effective_status"
    t.string "title"
    t.string "short_description"
    t.text "description"
    t.string "equivalent_id"
    t.string "allow_multi_enroll"
    t.integer "max_units"
    t.integer "min_units"
    t.integer "repeat_units_limit"
    t.string "grading"
    t.string "component"
    t.string "primary_component"
    t.integer "offering_number"
    t.string "academic_group"
    t.string "subject"
    t.string "catalog_number"
    t.string "campus"
    t.string "academic_org"
    t.string "academic_career"
    t.string "cip_code"
    t.string "campus_code"
    t.string "catalog_level"
    t.string "subject_desc"
    t.text "course_attributes"
    t.string "course_id"
  end

  create_table "enrollments", force: :cascade do |t|
    t.integer "student_id"
    t.integer "section_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sections", force: :cascade do |t|
    t.string "section_number"
    t.string "term"
    t.string "campus"
    t.string "schedule"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "instructor_id"
    t.bigint "course_id", null: false
    t.string "class_number", null: false
    t.string "component", null: false
    t.string "instruction_mode"
    t.date "start_date"
    t.date "end_date"
    t.string "enrollment_status"
    t.string "status"
    t.string "type"
    t.string "associated_class"
    t.boolean "auto_enroll_waitlist"
    t.string "auto_enroll_section1"
    t.string "auto_enroll_section2"
    t.boolean "consent"
    t.integer "waitlist_capacity"
    t.integer "minimum_enrollment"
    t.integer "enrollment_total"
    t.integer "waitlist_total"
    t.string "location"
    t.string "primary_instructor_section"
    t.string "combined_section"
    t.string "holiday_schedule"
    t.string "session_code"
    t.string "session_description"
    t.jsonb "section_attributes"
    t.string "section"
    t.integer "course_offering_number"
    t.string "academic_group"
    t.string "subject"
    t.string "catalog_number"
    t.string "career"
    t.text "description"
    t.string "academic_org"
    t.string "equivalent_course_id"
    t.date "cancel_date"
    t.string "sec_campus"
    t.string "sec_academic_group"
    t.string "sec_catalog_number"
    t.string "meeting_days"
    t.integer "number_of_graders"
    t.string "name"
    t.time "start_time"
    t.time "end_time"
    t.string "days"
    t.index ["class_number"], name: "index_sections_on_class_number", unique: true
    t.index ["course_id"], name: "index_sections_on_course_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "role"
    t.boolean "approved", default: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.boolean "admin"
  end

  add_foreign_key "approvals", "users"
  add_foreign_key "sections", "courses"
end
