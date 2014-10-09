class V1::ProductCategoriesController < ApplicationController

  # DO NOT RE-ORDER OR INSERT NEW ENTRIES. ALWAYS APPEND AT THE END
  PRODUCT_CATEGORIES = [
    ['unspecified'],
    ['others'],
    ['Refrigerators','others','Samsung', 'LG', 'Whirlpool', 'Godrej', 'Panasonic', 'Hitachi', 'Electrolux', 'Kelvinator'],
    ['TVs','others','Samsung', 'LG', 'Panasonic', 'Videocon', 'Onida', 'Sony', 'Toshiba', 'Sharp'],
    ['Washing Machnies','others','Voltas', 'LG', 'Hitachi', 'Samsung', 'Panasonic', 'Godrej', 'Daikin'],
    ['Washing Machines','others', 'Siemens', 'IFB', 'Samsung', 'Videocon', 'LG', 'Whirlpool', 'Bosch', 'Godrej'],
    ['Water Purifiers','others', 'Kent', 'Eureka Forbes', 'LG', 'Whirlpool', 'Essel Nasaka'],
    ['Home Theatres','others','Samsung', 'Philips', 'Panasonic', 'Onida', 'Sony', 'LG'],
    ['Music System','others', 'Philips', 'Yamaha', 'Sony', 'Lenco', 'Denon'],
    ['Camera','others','Sony', 'Canon', 'Nikon', 'Samsung', 'Kodak', 'Panasonic', 'Fujifilm', 'Olympus'],
    ['Mobile','others', 'Samsung', 'Nokia', 'Micromax', 'HTC', 'LG', 'Karbonn', 'Spice', 'Sony', 'Blackberry', 'Lava', 'Motorola', 'Videocon', 'Intex', 'Apple', 'Asus'],
    ['Tablets','others', 'HCL', 'Micromax', 'Samsung', 'BSNL', 'Karbonn', 'Sony', 'iBall', 'Lenovo', 'Acer', 'Intex', 'Swipe', 'apple'],
    ['Laptops','others', 'Dell', 'HP', 'Lenovo', 'Sony', 'Acer', 'Samsung', 'Toshiba', 'Asus', 'Apple']
  ]

  def index
    @@hash = Hash[
      PRODUCT_CATEGORIES.each_with_index.map{ |product_category, product_category_index| [
        product_category_index,
        Hash[product_category.each_with_index.map{ |product, product_index| [
          product_index, product
        ]}]
      ]}
    ]
    render json: @@hash
  end

end
