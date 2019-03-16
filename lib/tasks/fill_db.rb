require 'csv'
require './lib/tasks/fill_db_services/creator.rb'

class FillDb
  def initialize(path_to_files)
    @path_to_files = path_to_files
  end

  def perform!
    Dir["#{Rails.root}/#{@path_to_files}/*.csv"].each{ |path| handle_csv(path) }
  end

  def handle_csv(path)
    CSV.foreach(path) { |row| FillDbServices::Creator.new(row).perform! }
  end
end
