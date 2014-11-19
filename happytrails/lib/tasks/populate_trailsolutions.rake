namespace :db do
  desc "populate trailsolutions"
  task :populate_trailsolutions => :environment do
    file_path = Rails.root + 'lib/trails.txt'
    data = File.read(file_path)

    def split_on_word_if_its_there(arr,word)
      arr.map! { |datapoint| datapoint.include?(word) ? datapoint.partition(word) : datapoint }
    end

    data = data.split("\n")
    data.map! { |datapoint| datapoint.include?("Appalachian National Scenic Trail") ? datapoint.partition("Appalachian National Scenic Trail") : datapoint }
    data.flatten!
    data.map { |datapoint| datapoint.include?("Long Distance Trails") ? datapoint.partition("Long Distance Trails") : datapoint }
    data.flatten!


    facilities = data.split("\<facility\>")[1..-1]

    facilities.each do |facility|
      if facility.include?("\</Prop_ID\>") && ("\<Prop_ID\>")
        prop_ID = facility.split("\<Prop_ID\>")[1].split("\<")[0]
      end
      name = facility.include?(("\</Name\>") && ("\<Name\>")) ? facility.split("\<Name\>")[1].split("\<")[0] : ""
      location = facility.include?(("\</Location\>\n") && ("\<Location\n\>")) ? facility.split("\<Location\>\n")[1].split("\n\<")[0] : ""
      park_name = facility.include?(("\</Park_Name\>") && ("\<Park_Name\>")) ? facility.split("\<Park_Name\>")[1].split("\<")[0] : ""
      length = facility.include?(("\</Length\>") && ("\<Length\>")) ? facility.split("\<Length\>")[1].split("\<")[0] : ""
      difficulty = facility.include?(("\</Difficulty\>") && ("\<Difficulty\>")) ? facility.split("\<Difficulty\>")[1].split("\<")[0] : ""
      other_details = facility.include?(("\</Other_Details\>\n") && ("\<Other_Details\n\>")) ? facility.split("\<Other_Details\>\n")[1].split("\n\<")[0] : ""
      if facility.include?("\</Accessible\>") && ("\<Accessible\>")
        accessible = ((facility.split("\<Accessible\>")[1].split("\<")[0])=="Y")
      end
      if facility.include?("\</Limited_Access\>") && ("\<Limited_Access\>")
        limited_access = ((facility.split("\<Limited_Access\>")[1].split("\<")[0])=="Y")
      end
      Trailsolution.create!(
        prop_ID: prop_ID,
        name: name,
        location: location,
        park_name: park_name,
        length: length,
        difficulty: difficulty,
        other_details: other_details,
        accessible: accessible,
        limited_access: limited_access
        )
    end
  end
end