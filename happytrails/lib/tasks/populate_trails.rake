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

    img_arr = []
    p_arr_arr = []
    url_arr.each do |url|
      response = HTTParty.get(url)
      img_string = response.slice(/<img.+class="imagecache/)
      if img_string != nil
        img = img_string.slice(/http.+JPG/i)
        img_arr.push(img)
      else
        img_arr.push("")
      end

      description_string = response.slice(/<div class=\"hike-heading\">Description<\/div>.+<div class=\"stop\">/m)
      if description_string != nil
        p_arr = description_string.split("</p>")
        idx0 = p_arr.shift
        p_arr.unshift("<p>" + idx0.split("<p>")[-1])
        p_arr.map! { |p| p.lstrip.split("<br /> <br /> ") }
        p_arr.map! { |p| p.include?("<img") ? p.gsub!(/<img.+>/,"") : p}
        p_arr.map! { |p| p.include?("<a href") ? p.gsub!(/<a\shref.+>/,"") : p}
        p_arr.map! do |p|
          if p.include?("<em>")
            split1 = p.split("<em>")
            split2 = split1.map!{|text|text.split("</em>")}
            split2.flatten!
            emphasized = []
            split2.each_with_index do |text, i|
              if i%2 == 1
                emphasized.push(text.upcase)
              else
                emphasized.push(text)
              end
            end
            return emphasized
          else
            return p
          end
        end

        end
        p_arr.flatten!
        index_array = []
        p_arr.each_with_index do |p,i|
          if p[0..4] == "</div"
            index_array.push(i)
          end
        end
        if index_array != []
          p_arr = p_arr[0..index_array[0]-1]
          p_arr.map! { |p| p[3..-1] }
          p_arr_arr.push(p_arr)
        else
          p_arr_arr.push([""])
        end
      else
        p_arr_arr.push([""])
      end

      sleep 1
    end

    data.each_with_index do |arr, index|
      arr.push(img_arr[index])
      arr.push(p_arr_arr[index])
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
      lat = (trail[8] != "") ? (trail[8].split(",")[0].split(" ")[-1]).to_f : 0.0
      lon = (trail[8] != "") ? (trail[8].split(",")[1].strip.split(" ")[0]).to_f : 0.0
      url = trail[9]
      img = trail[10]
      p_arr = trail[11]
      t = Trail.create!(
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
        url: url,
        img: img
        )
      p_arr.each_with_index do |p,i|
        Paragraph.create!(
          body: p,
          index: i,
          trail_id: t.id
          )
      end
    end

    Trail.sweeptrails

    Trail.setgeocoordinates

  end
end

