require 'httparty'

class FetchClassInfo
  include HTTParty

  def initialize(term:, campus:, page: 1, subject: 'cse')
    @options = "?q=" + subject + "&campus=" + campus + "&term=" + term
  end

  def call
    puts "Making API request with options: #{@options.inspect}"
    response = self.class.get('https://content.osu.edu/v2/classes/search' + @options)

    if response.success?
      puts "API response received: #{response.parsed_response.inspect}"
      process_response(response.parsed_response)
    else
      puts "Error fetching class info: #{response.code} - #{response.message}"
      raise "Error fetching class info: #{response.code} - #{response.message}"
    end
  end

  private

  def process_response(response_data)
    courses_data = response_data.dig('data', 'courses')
    puts "Extracted courses data: #{courses_data.inspect}"

    unless courses_data
      puts "Unexpected response structure: 'courses' key not found"
      raise "Unexpected response structure: 'courses' key not found"
    end

    courses_data.each do |course_entry|
      course_data = course_entry['course']
      next unless course_data
      next unless valid_course_data?(course_data)

      puts "Processing course data: #{course_data.inspect}"

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
        credits: course_data['maxUnits'] # Ensure this is set
      }

      course = Course.find_or_initialize_by(course_number: course_data['catalogNumber'])
      course.assign_attributes(course_attributes)

      if course.save
        puts "Course #{course.course_number} saved successfully."
      else
        puts "Error saving course #{course.course_number}: #{course.errors.full_messages.join(', ')}"
      end
    end
    puts "Class information imported successfully."
  end

  def valid_course_data?(course_data)
    # Add conditions to filter out invalid data
    return false if course_data['catalogNumber'].nil?
    return false if course_data['title'].nil?
    return false if course_data['description'].nil?
    return false if course_data['maxUnits'].nil?

    true
  end
end
