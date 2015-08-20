namespace :populate do
  task :quotations => :environment do
    V1::Product.all.each do |p|
      puts p.brand_name.sellers.shuffle.first(5).count
      puts '---------------'
      p.brand_name.sellers.shuffle.first(5).each_with_index do |s,i|
        puts i
        q = V1::Quotation.new
        q.product = p
        q.seller = s
        q.price = p.their_price + 100*i
        puts q.save
      end
    end
  end
end
