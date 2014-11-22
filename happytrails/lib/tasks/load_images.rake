namespace :db do
  desc "load images into txt file"
  task :load_images => :environment do
    url_path = Rails.root + 'lib/urls_arr.txt'
    urls_from_txt = File.read(url_path)
    url_arr = urls_from_txt.split(/\d+:\s/)
    url_arr.shift
    url_arr.map! {|url| url[1..-2]}

    img_arr = []
    url_arr.each do |url|
      response = HTTParty.get(url)
      img_string = response.slice(/<img.+class="imagecache/)
      img = img_string.slice(/http.+JPG/i)
      img_arr.push(img)
      sleep 1
    end
  end
end

