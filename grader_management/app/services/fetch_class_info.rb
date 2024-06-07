require 'httparty'

class FetchClassInfo
  include HTTParty
  base_uri 'https://contenttest.osu.edu'

  def initialize(term:, campus:, page: 1, subject: 'cse')
    @options = {
      query: {
        q: '',
        client: 'class-search-ui',
        campus: campus,
        p: page,
        term: term,
        'academic-career': 'ugrad',
        subject: subject,
        'class-attribute': 'ge2'
      }
    }
  end

  def call
    response = self.class.get('/v2/classes/search', @options)
    if response.success?
      courses_data = response.parsed_response.dig('data', 'courses')
      if courses_data
        courses_data.each do |course_entry|
          course_data = course_entry['course']
          next unless course_data

          course = Course.find_or_initialize_by(course_number: course_data['catalogNumber'])
          course.course_name = course_data['title']
          course.course_description = course_data['description']
          course.credits = course_data['maxUnits']
          course.save!
        end
        puts "Class information imported successfully."
      else
        puts "No courses found in the response."
      end
    else
      puts "Error fetching class info: #{response.code} - #{response.message}"
    end
  end
end

# Initialize and call the class
fetcher = FetchClassInfo.new(term: '1244', campus: 'col')
fetcher.call
