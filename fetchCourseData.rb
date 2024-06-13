class CoursesController < ApplicationController
  def reload
    response = HTTParty.get('https://contenttest.osu.edu/v2/classes/search', {
      query: { client: 'class-search-ui', campus: 'col', p: 1, term: '1244', academic-career: 'ugrad', subject: 'cse' }
    })
    #save answer data to the database
  end
end
