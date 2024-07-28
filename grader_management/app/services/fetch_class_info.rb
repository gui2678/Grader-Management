class FetchClassInfo
  require 'net/http'
  require 'json'

  BASE_URL = 'https://contenttest.osu.edu/v2/classes/search'

  def initialize(term:, campus:, page: 1, subject: 'cse')
    @options = "?q=" + subject + "&campus=" + campus + "&term=" + term + "&p=" + page.to_s
  end

  def call
    url = URI(BASE_URL + @options)
    Rails.logger.info "Making API request to: #{url}"

    response = fetch_class_info(url)

    if response
      Rails.logger.info "API response received: #{response.inspect}"
      process_response(response)
    else
      Rails.logger.error "Error fetching class info"
      raise "Error fetching class info"
    end
  rescue StandardError => e
    Rails.logger.error "Exception in FetchClassInfo: #{e.message}\n#{e.backtrace.join("\n")}"
  end

  private

  def fetch_class_info(url)
    response = Net::HTTP.get_response(url)
    if response.is_a?(Net::HTTPSuccess)
      JSON.parse(response.body)
    else
      Rails.logger.error "HTTP request failed: #{response.code} - #{response.message}"
      nil
    end
  rescue JSON::ParserError => e
    Rails.logger.error "JSON::ParserError in FetchClassInfo: #{e.message}\n#{e.backtrace.join("\n")}"
    nil
  end

  def process_response(response_data)
    courses_data = response_data.dig('data', 'courses')
    Rails.logger.info "Extracted courses data: #{courses_data.inspect}"

    unless courses_data
      Rails.logger.error "Unexpected response structure: 'courses' key not found"
      raise "Unexpected response structure: 'courses' key not found"
    end

    if courses_data.empty?
      Rails.logger.warn "No courses found for these params."
      Rails.application.env_config['action_dispatch.request.flash_hash'] = ActionDispatch::Flash::FlashHash.new
      Rails.application.env_config['action_dispatch.request.flash_hash'][:notice] = "No courses found for these params."
      return
    end

    courses_data.each do |course_entry|
      course_data = course_entry['course']
      next unless course_data
      next unless valid_course_data?(course_data)

      Rails.logger.info "Processing course data: #{course_data.inspect}"

      course_attributes = {
        term: course_data['term'],
        effective_date: course_data['effectiveDate'],
        effective_status: course_data['effectiveStatus'],
        course_name: course_data['title'],
        short_description: course_data['shortDescription'],
        course_description: course_data['description'],
        equivalent_id: course_data['equivalentId'],
        allow_multi_enroll: course_data['allowMultiEnroll'],
        max_units: course_data['maxUnits'],
        min_units: course_data['minUnits'],
        repeat_units_limit: course_data['repeatUnitsLimit'],
        grading: course_data['grading'],
        component: course_data['component'],
        primary_component: course_data['primaryComponent'],
        offering_number: course_data['offeringNumber'],
        academic_group: course_data['academicGroup'],
        subject: course_data['subject'],
        catalog_number: course_data['catalogNumber'],
        campus: course_data['campus'],
        academic_org: course_data['academicOrg'],
        academic_career: course_data['academicCareer'],
        cip_code: course_data['cipCode'],
        campus_code: course_data['campusCode'],
        catalog_level: course_data['catalogLevel'],
        subject_desc: course_data['subjectDesc'],
        course_attributes: course_data['courseAttributes'],
        course_id: course_data['courseId'],
        credits: course_data['maxUnits']
      }

      course = Course.find_or_initialize_by(course_number: course_data['catalogNumber'])
      course.assign_attributes(course_attributes)

      if course.save
        Rails.logger.info "Course #{course.course_number} saved successfully."
      else
        Rails.logger.error "Error saving course #{course.course_number}: #{course.errors.full_messages.join(', ')}"
      end
    end
    Rails.logger.info "Class information imported successfully."
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
  def valid_course_data?(course_data)
    required_keys = %w[catalogNumber title description maxUnits]
    required_keys.all? { |key| course_data[key].present? }
  end
end
