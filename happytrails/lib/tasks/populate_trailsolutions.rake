require 'csv'

namespace :db do
  desc "populate trailsolutions"
  task :populate_trailsolutions => :environment do
    file_path = Rails.root + 'lib/trails.txt'
    data_from_txt = File.read(file_path)
    data_from_txt = data_from_txt.split("\n")
    data_from_txt.reject!{|line| line=="\""}
    data_from_txt.map! do |line|
      line = line[1..-7]
      line.strip!
    end

    data = []
    arr = []
    data_from_txt.each_with_index do |line,i|
      if (i+1) % 10 == 0
        arr.push(line)
        data.push(arr)
        arr = []
      else
        arr.push(line)
      end
    end

    data.each do |trail|
      park = trail[0]
      title = trail[1]
      region = trail[2]
      state = trail[3]
      length = trail[4]
      difficulty = trail[5]
      features = trail[6]
      dogs = trail[7]
      lat = (trail[8] != "") ? (trail[8].split(",")[0].split(" ")[-1]) : ""
      lon = (trail[8] != "") ? (trail[8].split(",")[1].strip.split(" ")[0]) : ""
      Trailsolution.create!(
        park: park,
        title: title,
        region: region,
        state: state,
        length: length,
        difficulty: difficulty,
        features: features,
        dogs: dogs,
        lat: lat,
        lon: lon
        )
    end
  end
end