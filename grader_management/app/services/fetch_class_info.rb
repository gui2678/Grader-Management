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
      course_record = process_course(course_data['course'])
      process_sections(course_data['sections'], course_record)
    end
  end

  def process_course(course_data)
    course = Course.find_or_initialize_by(course_number: course_data['catalogNumber'])
    course.assign_attributes(
      course_name: course_data['title'],
      course_description: course_data['description'],
      credits: course_data['maxUnits'],
      term: course_data['term'],
      course_attributes_json: course_data['courseAttributes']
    )
    if course.save
      Rails.logger.info "Course #{course.course_number} saved successfully."
    else
      Rails.logger.error "Error saving course #{course.course_number}: #{course.errors.full_messages.join(', ')}"
    end
    course
  end

  def process_sections(sections_data, course)
    return unless course
  
    sections_data.each do |section_data|
      section = course.sections.find_or_initialize_by(class_number: section_data['classNumber'])
      section.assign_attributes(
        section_number: section_data['section'],
        component: section_data['component'],
        term: section_data['term'],
        campus: section_data['campus'],
        meeting_days: section_data['meetingDays'],
        start_time: section_data['startTime'],    
        end_time: section_data['endTime'],        
        instructor_id: section_data['instructorId'] 
      )
      if section.save
        Rails.logger.info "Section #{section.section_number} for course #{course.course_number} saved successfully."
        process_meetings(section, section_data['meetings'])
      else
        Rails.logger.error "Error saving section #{section.section_number} for course #{course.course_number}: #{section.errors.full_messages.join(', ')}"
      end
    end
  end

  def process_meetings(section, meetings_data)
    meetings_data.each do |meeting_data|
      Rails.logger.info "Processing meeting data: #{meeting_data.inspect}"
  
      meeting = section.meetings.find_or_initialize_by(meeting_number: meeting_data['meetingNumber'])
  
      class_number = section.class_number
      section_number = section.section_number
      component = section.component
  
      # Log the attributes to ensure they are present
      Rails.logger.info "Class number: #{class_number}, Section number: #{section_number}, Component: #{component}"
  
      meeting.assign_attributes(
        course_id: section.course_id,
        section_id: section.id,
        class_number: class_number,
        section_number: section_number,
        component: component,
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
        instructors_json: meeting_data['instructors']
      )
  
      if meeting.save
        Rails.logger.info "Meeting #{meeting.meeting_number} saved successfully."
      else
        Rails.logger.error "Error saving meeting #{meeting.meeting_number}: #{meeting.errors.full_messages.join(', ')}"
      end
    end
  end
  
  
  
end
