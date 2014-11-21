require 'csv'

namespace :db do
  desc "populate trails"
  task :populate_trails => :environment do
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

    url_path = Rails.root + 'lib/urls_arr.txt'
    urls_from_txt = File.read(url_path)
    url_arr = urls_from_txt.split(/\d+:\s/)
    url_arr.shift
    url_arr.map! {|url| url[1..-2]}

    data.each_with_index do |arr, index|
      arr.pop
      arr.push(url_arr[index])
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
      url = trail[9]
      Trail.create!(
        park: park,
        title: title,
        region: region,
        state: state,
        length: length,
        difficulty: difficulty,
        features: features,
        dogs: dogs,
        lat: lat,
        lon: lon,
        url: url
        )
    end
  end
end