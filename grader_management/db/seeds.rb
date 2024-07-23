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
admin = User.find_or_create_by!(
  email: 'admin@osu.edu',
  first_name: 'Admin',
  last_name: 'User',
  role: 'admin',
  approved: true
)
admin.password = 'password'
admin.password_confirmation = 'password'
admin.save!

instructor = User.find_or_create_by!(
  email: 'instructor@osu.edu',
  first_name: 'Instructor',
  last_name: 'User',
  role: 'instructor',
  approved: true
)
instructor.password = 'password'
instructor.password_confirmation = 'password'
instructor.save!

student = User.find_or_create_by!(
  email: 'student@osu.edu',
  first_name: 'Student',
  last_name: 'User',
  role: 'student',
  approved: true
)
student.password = 'password'
student.password_confirmation = 'password'
student.save!

# example courses
course1 = Course.find_or_create_by!(
  course_number: 'CSE101',
  course_name: 'Introduction to Computer Science',
  course_description: 'An introductory course in computer science.',
  credits: 3
)

course2 = Course.find_or_create_by!(
  course_number: 'CSE201',
  course_name: 'Data Structures',
  course_description: 'A course on data structures.',
  credits: 3
)

# example sections for the courses
Section.find_or_create_by!(
  name: 'Section 1',
  course: course1,
  class_number: '001',
  component: 'Lecture',
  start_time: '2000-01-01 10:00:00',
  end_time: '2000-01-01 10:50:00',
  days: 'MWF',
  instructor: instructor,
  term: 'Fall 2023',
  campus: 'Main',
  schedule: 'MWF 10:00-10:50'
)

Section.find_or_create_by!(
  name: 'Section 2',
  course: course2,
  class_number: '002',
  component: 'Lecture',
  start_time: '2000-01-01 11:00:00',
  end_time: '2000-01-01 12:15:00',
  days: 'TTh',
  instructor: instructor,
  term: 'Fall 2023',
  campus: 'Main',
  schedule: 'TTh 11:00-12:15'
)
