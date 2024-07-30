# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

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

# Example sectinss for the courses
section1 = Section.find_or_create_by!(
  name: 'Section 1',
  course: course1,
  class_number: '001',
  component: 'Lecture',
  start_date: '2023-08-21',
  end_date: '2023-12-15',
  days: 'MWF',
  instructor: instructor,
  term: 'Fall 2023',
  campus: 'Main',
  schedule: 'MWF 10:00-10:50',
  section_number: 1
)

section2 = Section.find_or_create_by!(
  name: 'Section 2',
  course: course2,
  class_number: '002',
  component: 'Lecture',
  start_date: '2023-08-21',
  end_date: '2023-12-15',
  days: 'TTh',
  instructor: instructor,
  term: 'Fall 2023',
  campus: 'Main',
  schedule: 'TTh 11:00-12:15',
  section_number: 2
)

# Example meetings for the sections
Meeting.find_or_create_by!(
  course: course1,
  section: section1,
  class_number: '001',
  section_number: '001',
  component: 'Lecture',
  start_date: '2023-08-21',
  end_date: '2023-12-15',
  monday: true,
  wednesday: true,
  friday: true,
  start_time: '10:00:00',
  end_time: '10:50:00',
  building_code: 'DL',
  room: '101',
  instructors_json: [{ displayName: instructor.first_name + ' ' + instructor.last_name, role: 'PI', email: instructor.email }].to_json
)

Meeting.find_or_create_by!(
  course: course2,
  section: section2,
  class_number: '002',
  section_number: '002',
  component: 'Lecture',
  start_date: '2023-08-21',
  end_date: '2023-12-15',
  tuesday: true,
  thursday: true,
  start_time: '11:00:00',
  end_time: '12:15:00',
  building_code: 'DL',
  room: '102',
  instructors_json: [{ displayName: instructor.first_name + ' ' + instructor.last_name, role: 'PI', email: instructor.email }].to_json
)

GraderApplication.find_or_create_by!(
  display_name: 'Test Grader Approved',
  first_name: 'Test',
  middle_name: 'Grader',
  last_name: 'Approved',
  legal_last_name: 'Approved',
  name_suffix: 'Jr',
  username: 'approved_grader',
  email: 'approved_grader@osu.edu',
  address: '1234 Main St',
  phone: '555-1234',
  user: student,
  course: course1,
  section: section1,
  approved: true
)

GraderApplication.find_or_create_by!(
  display_name: 'Test Grader Unapproved',
  first_name: 'Test',
  middle_name: 'Grader',
  last_name: 'Unapproved',
  legal_last_name: 'Unapproved',
  name_suffix: 'Sr',
  username: 'unapproved_grader',
  email: 'unapproved_grader@osu.edu',
  address: '5678 Main St',
  phone: '555-5678',
  user: student,
  course: course2,
  section: section2,
  approved: false
)
