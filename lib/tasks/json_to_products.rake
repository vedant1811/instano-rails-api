namespace :parse do
  desc "scrape flipkart products scraped by ravinder. Use FILE_PATH to specify input file. It is long running. Best to do `nohup rake parse:flipkart_products FILE_PATH=/home/ubuntu/outputData.json RAILS_ENV=staging &`"
  task :flipkart_products => :environment do
    file = open(ENV['FILE_PATH'])
    ruby_object = JSON.parse file.read
    # [{"category"=>"Washing Machines", "features"=>"Capacity: 7 kg,Fully Automatic", "imagelinks"=>"http://img6a.flixcart.com/image/washing-machine-new/c/m/f/lg-t80cme21p-original-imadz3ghf9sbhrhu.jpeg", "brand"=>"LG", "productname"=>"LG T80CME21P 7 kg Fully Automatic Top Loading Washing Machine", "link"=>"https://www.flipkart.com/lg-t80cme21p-7-kg-fully-automatic-top-loading-washing-machine/p/itmdyakvcgfq6ryw?pid=WMNDY9RWFYHNMCMF", "sellingprice"=>20790}, ...]
    puts "starting parse"
    n = 0
    ruby_object.each do |product|
      status = "scraped"
      v1_product = V1::Product.new
      v1_product.name = product['productname']
      next if V1::Product.exists?(name: v1_product.name)
      retry_attempts = 7
      begin
        v1_product.image = product['imagelinks']
        v1_product.their_price = product['sellingprice']
        v1_product.url = product['link']
        v1_product.features = product['features']

        category_name = nil
        if product['category']
          category_name = V1::CategoryName.where('lower(name) = ?', product['category'].downcase).first
          category_name ||= V1::CategoryName.create!(name: product['category'])
        else
          status = "on_hold"
        end
        brand = "" # empty string
        if product['brand']
          brand = product['brand']
        else
          status = "on_hold"
        end

        if category_name
          brand_name = V1::BrandName.where(category_name: category_name, name: brand).first_or_create!
          v1_product.brand_name = brand_name
        end

        v1_product.device = V1::Device.find_or_create_by!(gcm_registration_id: "ravidner")
        v1_product.status = status
        if v1_product.save
          n+=1
          puts "new product. n = #{n}"
        else
          puts v1_product.errors.inspect
        end
      rescue => error # rescue any standard error and try again after a delay
        puts error.inspect
        if retry_attempts > 0
          retry_attempts -= 1
          sleep 5
          puts "retrying"
          retry
        end
        puts "skipping after 7 failed attempts"
        puts v1_product.inspect
      end # begin end
    end # loop end
    puts "parse complete"
  end
end
