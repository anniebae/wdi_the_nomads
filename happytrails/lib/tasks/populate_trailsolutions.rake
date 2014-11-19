gem 'pry'

namespace :db do
  desc "populate trailsolutions"
  task :populate_trailsolutions do
    file_path = Rails.root + 'lib/trails.txt'
    data = File.read(file_path)

    binding.pry

  end
end