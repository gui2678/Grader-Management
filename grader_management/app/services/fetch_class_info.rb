class FetchClassInfo
  require 'net/http'
  require 'json'

  BASE_URL = 'https://contenttest.osu.edu/v2/classes/search'

  def initialize(term:, campus:)
    @term = term
    @campus = campus
  end

  def call
    response = fetch_class_info
    process_response(response) if response
  rescue StandardError => e
    Rails.logger.error "Exception in FetchClassInfo: #{e.message}\n#{e.backtrace.join("\n")}"
    raise "Exception in FetchClassInfo: #{e.message}"
  end

  private

  def fetch_class_info
    url = URI("#{BASE_URL}?q=cse&campus=#{@campus}&term=#{@term}&p=1")
    response = Net::HTTP.get(url)
    JSON.parse(response)
  rescue JSON::ParserError => e
    Rails.logger.error "JSON::ParserError in FetchClassInfo: #{e.message}\n#{e.backtrace.join("\n")}"
    nil
  end

  def process_response(response)
    courses_data = response['data']['courses']
    courses_data.each do |course_data|
      process_course(course_data)
    end
  end

  def process_course(course_data)
    course = Course.find_or_initialize_by(course_number: course_data['catalogNumber'])
    course.assign_attributes(
      title: course_data['title'],
      short_description: course_data['shortDescription'],
      description: course_data['description'],
      term: course_data['term'],
      credits: course_data['maxUnits'],
      academic_org: course_data['academicOrg'],
      academic_career: course_data['academicCareer'],
      component: course_data['component'],
      subject: course_data['subject'],
      campus: course_data['campus']
    )
    if course.save
      Rails.logger.info "Course #{course.course_number} saved successfully."
      process_sections(course, course_data['sections'])
    else
      Rails.logger.error "Error saving course #{course.course_number}: #{course.errors.full_messages.join(', ')}"
    end
  end

  def process_sections(course, sections_data)
    sections_data.each do |section_data|
      section = course.sections.find_or_initialize_by(class_number: section_data['classNumber'])
      section.assign_attributes(extract_section_attributes(section_data))
      unless section.save
        Rails.logger.error "Error saving section #{section.class_number}: #{section.errors.full_messages.join(', ')}"
      end
    end
  end

  def extract_section_attributes(section_data)
    {
      class_number: section_data['classNumber'],
      section_number: section_data['section'],
      component: section_data['component'],
      instruction_mode: section_data['instructionMode'],
      start_date: section_data['startDate'],
      end_date: section_data['endDate'],
      enrollment_status: section_data['enrollmentStatus'],
      status: section_data['status'],
      section_type: section_data['type'],
      associated_class: section_data['associatedClass'],
      auto_enroll_waitlist: section_data['autoEnrollWaitlist'],
      auto_enroll_section1: section_data['autoEnrollSection1'],
      auto_enroll_section2: section_data['autoEnrollSection2'],
      consent: section_data['consent'],
      waitlist_capacity: section_data['waitlistCapacity'],
      minimum_enrollment: section_data['minimumEnrollment'],
      enrollment_total: section_data['enrollmentTotal'],
      waitlist_total: section_data['waitlistTotal'],
      location: section_data['location'],
      primary_instructor_section: section_data['primaryInstructorSection'],
      combined_section: section_data['combinedSection'],
      holiday_schedule: section_data['holidaySchedule'],
      session_code: section_data['sessionCode'],
      session_description: section_data['sessionDescription'],
      term: section_data['term'],
      campus: section_data['campus'],
      section_attributes: section_data['attributes'],
      sec_campus: section_data['secCampus'],
      sec_academic_group: section_data['secAcademicGroup'],
      sec_catalog_number: section_data['secCatalogNumber'],
      meeting_days: section_data['meetingDays']
    }
  end

  def process_meetings(section, meetings_data)
    meetings_data.each do |meeting_data|
      meeting = section.meetings.find_or_initialize_by(meeting_number: meeting_data['meetingNumber'])
      meeting.assign_attributes(
        facility_id: meeting_data['facilityId'],
        facility_type: meeting_data['facilityType'],
        facility_description: meeting_data['facilityDescription'],
        facility_description_short: meeting_data['facilityDescriptionShort'],
        facility_capacity: meeting_data['facilityCapacity'],
        building_code: meeting_data['buildingCode'],
        room: meeting_data['room'],
        building_description: meeting_data['buildingDescription'],
        building_description_short: meeting_data['buildingDescriptionShort'],
        start_time: meeting_data['startTime'],
        end_time: meeting_data['endTime'],
        start_date: meeting_data['startDate'],
        end_date: meeting_data['endDate'],
        monday: meeting_data['monday'],
        tuesday: meeting_data['tuesday'],
        wednesday: meeting_data['wednesday'],
        thursday: meeting_data['thursday'],
        friday: meeting_data['friday'],
        saturday: meeting_data['saturday'],
        sunday: meeting_data['sunday'],
        standing_meeting_pattern: meeting_data['standingMeetingPattern']
      )
      unless meeting.save
        Rails.logger.error "Error saving meeting #{meeting.meeting_number}: #{meeting.errors.full_messages.join(', ')}"
      end

      process_instructors(meeting, meeting_data['instructors'])
    end
  end

  def process_instructors(meeting, instructors_data)
    instructors_data.each do |instructor_data|
      instructor = User.find_or_initialize_by(email: instructor_data['email'])
      instructor.assign_attributes(
        first_name: instructor_data['displayName'].split(' ').first,
        last_name: instructor_data['displayName'].split(' ').last
      )
      unless instructor.save
        Rails.logger.error "Error saving instructor #{instructor.email}: #{instructor.errors.full_messages.join(', ')}"
      end

      meeting.instructors << instructor unless meeting.instructors.include?(instructor)
    end
  end
end
