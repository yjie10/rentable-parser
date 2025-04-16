namespace :import do
  desc "Queue a background job to import properties from XML"
  task feed: :environment do
    path = "lib/assets/sample_abodo_feed.xml" # or replace with path to your xml file
    puts "[Rake] Enqueuing ImportPropertyFeedJob with file: #{path}"
    ImportPropertyFeedJob.perform_later(path)
    puts "[ActiveJob] Done importing!"
  end
end
