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

ActiveRecord::Schema[7.0].define(version: 2024_07_30_173928) do
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

  create_table "availabilities", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "monday"
    t.string "tuesday"
    t.string "wednesday"
    t.string "thursday"
    t.string "friday"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_availabilities_on_user_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "course_number", null: false
    t.string "course_name", null: false
    t.text "course_description", null: false
    t.integer "credits", null: false
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
    t.text "course_attributes_json"
    t.index ["course_number"], name: "index_courses_on_course_number", unique: true
  end

  create_table "enrollments", force: :cascade do |t|
    t.bigint "section_id", null: false
    t.integer "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["section_id"], name: "index_enrollments_on_section_id"
  end

  create_table "grader_applications", force: :cascade do |t|
    t.string "display_name", null: false
    t.string "first_name", null: false
    t.string "middle_name"
    t.string "last_name", null: false
    t.string "legal_last_name", null: false
    t.string "name_suffix"
    t.string "username", null: false
    t.string "email", null: false
    t.string "address", null: false
    t.string "phone", null: false
    t.bigint "user_id"
    t.bigint "course_id"
    t.bigint "section_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "approved", default: false
    t.index ["course_id"], name: "index_grader_applications_on_course_id"
    t.index ["section_id"], name: "index_grader_applications_on_section_id"
    t.index ["user_id"], name: "index_grader_applications_on_user_id"
  end

  create_table "meetings", force: :cascade do |t|
    t.bigint "section_id", null: false
    t.bigint "instructor_id"
    t.integer "meeting_number"
    t.string "facility_id"
    t.string "facility_type"
    t.string "facility_description"
    t.string "facility_description_short"
    t.integer "facility_capacity"
    t.string "building_code"
    t.string "room"
    t.string "building_description"
    t.string "building_description_short"
    t.string "start_time"
    t.string "end_time"
    t.date "start_date"
    t.date "end_date"
    t.boolean "monday"
    t.boolean "tuesday"
    t.boolean "wednesday"
    t.boolean "thursday"
    t.boolean "friday"
    t.boolean "saturday"
    t.boolean "sunday"
    t.string "standing_meeting_pattern"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "instructors_json"
    t.index ["instructor_id"], name: "index_meetings_on_instructor_id"
    t.index ["section_id"], name: "index_meetings_on_section_id"
  end

  create_table "recommendations", force: :cascade do |t|
    t.bigint "recommender_id", null: false
    t.integer "recommended_id"
    t.bigint "course_id", null: false
    t.text "message", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "display_name"
    t.string "first_name"
    t.string "middle_name"
    t.string "last_name"
    t.string "legal_last_name"
    t.string "name_suffix"
    t.string "email"
    t.string "section_number"
    t.string "username"
    t.index ["course_id"], name: "index_recommendations_on_course_id"
    t.index ["recommended_id"], name: "index_recommendations_on_recommended_id"
    t.index ["recommender_id"], name: "index_recommendations_on_recommender_id"
  end

  create_table "sections", force: :cascade do |t|
    t.string "section_number"
    t.bigint "course_id", null: false
    t.integer "instructor_id"
    t.string "term"
    t.string "campus"
    t.string "schedule"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "class_number"
    t.string "component"
    t.time "start_time"
    t.time "end_time"
    t.string "days"
    t.string "instruction_mode"
    t.string "enrollment_status"
    t.string "status"
    t.string "section_type"
    t.string "associated_class"
    t.boolean "auto_enroll_waitlist"
    t.integer "waitlist_capacity"
    t.integer "enrollment_total"
    t.string "primary_instructor_section"
    t.string "session_code"
    t.string "session_description"
    t.jsonb "section_attributes"
    t.date "start_date"
    t.date "end_date"
    t.string "auto_enroll_section1"
    t.string "auto_enroll_section2"
    t.integer "waitlist_total"
    t.string "section"
    t.integer "course_offering_number"
    t.string "academic_group"
    t.string "subject"
    t.string "catalog_number"
    t.string "career"
    t.text "description"
    t.boolean "consent"
    t.integer "minimum_enrollment"
    t.string "academic_org"
    t.string "location"
    t.string "equivalent_course_id"
    t.date "cancel_date"
    t.string "combined_section"
    t.string "holiday_schedule"
    t.string "sec_campus"
    t.string "sec_academic_group"
    t.string "sec_catalog_number"
    t.string "meeting_days"
    t.integer "number_of_graders"
    t.string "name"
    t.text "section_attributes_json"
    t.integer "max_graders"
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
  add_foreign_key "availabilities", "users"
  add_foreign_key "enrollments", "sections"
  add_foreign_key "grader_applications", "courses"
  add_foreign_key "grader_applications", "sections"
  add_foreign_key "grader_applications", "users"
  add_foreign_key "meetings", "sections"
  add_foreign_key "meetings", "users", column: "instructor_id"
  add_foreign_key "recommendations", "courses"
  add_foreign_key "recommendations", "users", column: "recommended_id"
  add_foreign_key "recommendations", "users", column: "recommender_id"
  add_foreign_key "sections", "courses"
end
