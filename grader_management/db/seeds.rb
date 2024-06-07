# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# example admin user
admin = User.create!(
  email: 'admin@example.com',
  password: 'password',
  password_confirmation: 'password',
  first_name: 'Admin',
  last_name: 'User',
  role: 'admin',
  approved: true
)

# example courses
course1 = Course.create!(
  course_number: 'CSE101',
  course_name: 'Introduction to Computer Science',
  course_description: 'An introductory course in computer science.',
  credits: 3
)

course2 = Course.create!(
  course_number: 'CSE201',
  course_name: 'Data Structures',
  course_description: 'A course on data structures.',
  credits: 3
)

# example sections for the courses
Section.create!(
  section_number: '001',
  course: course1,
  instructor_id: admin.id,
  term: 'Fall 2023',
  campus: 'Main',
  schedule: 'MWF 10:00-10:50'
)

Section.create!(
  section_number: '001',
  course: course2,
  instructor_id: admin.id,
  term: 'Fall 2023',
  campus: 'Main',
  schedule: 'TTh 11:00-12:15'
)
