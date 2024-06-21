# lib/tasks/import_classes.rake
namespace :import_classes do
  desc "Fetch class information from API"
  task fetch: :environment do
    FetchClassInfo.new(term: '1244', campus: 'col').call
  end
end
