require 'httparty'

class FetchClassInfo
  include HTTParty
  base_uri 'https://content.osu.edu'

  def initialize(term:, campus:, page: 1, subject: 'cse')
    @options = {
      query: {
        q: subject,
        client: 'class-search-ui',
        campus: campus,
        p: page,
        term: term,
        'academic-career': 'ugrad'
      }
    }
  end

  def call
    puts "Making API request with options: #{@options.inspect}"
    response = self.class.get('/v2/classes/search', @options)
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

      course = Course.find_or_initialize_by(course_number: course_data['catalogNumber'])
      course.course_name = course_data['title']
      course.course_description = course_data['description']
      course.credits = course_data['maxUnits']

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
