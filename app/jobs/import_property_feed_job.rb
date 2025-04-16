class ImportPropertyFeedJob < ApplicationJob
  queue_as :default

  def perform(file_path)
    XmlImporter.new(file_path).import
  end
end
