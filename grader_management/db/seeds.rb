# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Example users
admin = User.find_or_create_by!(email: 'admin.1@osu.edu') do |user|
  user.password = 'password'
  user.password_confirmation = 'password'
  user.first_name = 'Admin'
  user.last_name = 'User'
  user.role = 'admin'
  user.approved = true
end

instructor = User.find_or_create_by!(email: 'instructor.1@osu.edu') do |user|
  user.password = 'password'
  user.password_confirmation = 'password'
  user.first_name = 'Instructor'
  user.last_name = 'User'
  user.role = 'instructor'
  user.approved = true
end

student = User.find_or_create_by!(email: 'student.1@osu.edu') do |user|
  user.password = 'password'
  user.password_confirmation = 'password'
  user.first_name = 'Student'
  user.last_name = 'User'
  user.role = 'student'
  user.approved = true
end

# Example courses
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

# Example sections for the courses
Section.find_or_create_by!(
  name: 'Section 1',
  course: course1,
  class_number: '001',
  component: 'Lecture',
  start_date: '2000-01-01 10:00:00',
  end_date: '2000-01-01 10:50:00',
  days: 'MWF',
  instructor: instructor,
  term: 'Fall 2023',
  campus: 'Main',
  schedule: 'MWF 10:00-10:50',
  section_number: 1
)

Section.find_or_create_by!(
  name: 'Section 2',
  course: course2,
  class_number: '002',
  component: 'Lecture',
  start_date: '2000-01-01 11:00:00',
  end_date: '2000-01-01 12:15:00',
  days: 'TTh',
  instructor: instructor,
  term: 'Fall 2023',
  campus: 'Main',
  schedule: 'TTh 11:00-12:15',
  section_number: 2
)
