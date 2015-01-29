class ShopStyleAPI
  require 'httparty'

  # Convert from babybox's ClothingSizes to
  # ShopStyle clothing size ID
  CLOTHING_SIZES  = {
    0 => 318, # "0-3m"
    1 => 319, # "3-6m"
    2 => 320, # "6-9m"
    3 => 321, # "12-18m"
    4 => 322, # "24m"
    5 => 323, # "2T"
    6 => 351, # "3T"
    7 => 352, # "4T"
    8 => 377, # "5T"
    9 => 377, # "6T"
    10 => "X-Small"
  }

  # Price => ID
  SHOPSTYLE_PRICE_ID = {
    10  => 20,
    25  => 21,
    50  => 22,
    75  => 23,
    100 => 24,
    125 => 25,
    150 => 26,
    200 => 27,
    250 => 28,
    300 => 29,
    350 => 30
  }

  PID = ENV['SHOPSTYLE_API_KEY']

  # Initialize
  def initialize(style = 0, shirt_size = 6, pant_size = 6, jacket_size = 6, gender = "male", price = 50)
    @style       = 0
    @shirt_size  = shirt_size
    @pant_size   = pant_size
    @jacket_size = jacket_size
    @gender      = gender
    @price       = price
  end


  # Return Shirts API data
  # Polos, shirts, tees-and-tshirts
  def shirt_API_data
    if @style == 0 # Athletic
      # BUG = Currently pulling data for all shirts. But, need to order data where adidas, nike,
      #        under armour, and asics products are shown first
      tees_response = HTTParty.get("http://api.shopstyle.com/api/v2/products?pid=#{PID}&fl=s#{CLOTHING_SIZES[@shirt_size]}&fl=p20:#{SHOPSTYLE_PRICE_ID[@price]}&cat=boys-tees-and-tshirts&sort=Popular&limit=50&fl=b14$fl=b422$fl=b2184$fl=b2723")

      if tees_response.nil?
       tees_response = HTTParty.get("http://api.shopstyle.com/api/v2/products?pid=#{PID}&fl=s#{CLOTHING_SIZES[@shirt_size]}&fl=p20:#{SHOPSTYLE_PRICE_ID[@price]}&cat=boys-tees-and-tshirts&sort=Popular&limit=50")
      end


      shirt_products = JSON.parse(tees_response.body)["products"]
    elsif @style == 1 # Formal


    elsif @style == 2 # Everyday

    elsif @style == 3 # Play

    elsif @style == 4 # Trendy

    else
      puts "ERROR. No style indicated"
    end

    return shirt_products
  end

  # Return Jackets API data
  # Sweaters and sweatshirts
  def jackets_API_data
    if @style == 0 # Athletic
      # Sweatshirt products from Nike, adidas, Puma, Quiksilver, The North Face,
      # and Under Armour
      sweatshirts_response = HTTParty.get("http://api.shopstyle.com/api/v2/products?pid=#{PID}&fl=s#{CLOTHING_SIZES[@jacket_size]}&fl=p20:#{SHOPSTYLE_PRICE_ID[@price]}&cat=boys-sweatshirts&sort=Popular&limit=50&fl=b422&fl=b14&fl=b468&fl=b578&fl=b2184")

      jackets_products = JSON.parse(sweatshirts_response.body)["products"]
    elsif @style == 1 # Formal


    elsif @style == 2 # Everyday

    elsif @style == 3 # Play

    elsif @style == 4 # Trendy

    else
      puts "ERROR. No style indicated"
    end

    return jackets_products
  end

  # Return Bottoms API data
  # Shorts, jeans, and pants
  def bottoms_API_data
    if @style == 0 # Athletic
      pants_response = HTTParty.get("http://api.shopstyle.com/api/v2/products?pid=#{PID}&fl=s#{CLOTHING_SIZES[@pant_size]}&fl=p20:#{SHOPSTYLE_PRICE_ID[@price]}&cat=boys-pants&sort=Popular&limit=50&fl=b422&fl=b14&fl=b468&fl=b578&fl=b2184")

      pants_products = JSON.parse(pants_response.body)["products"]

      shorts_response = HTTParty.get("http://api.shopstyle.com/api/v2/products?pid=#{PID}&fl=s#{CLOTHING_SIZES[@pant_size]}&fl=p20:#{SHOPSTYLE_PRICE_ID[@price]}&cat=boys-shortss&sort=Popular&limit=50&fl=b422&fl=b14&fl=b468&fl=b578&fl=b2184")

      shorts_products = JSON.parse(shorts_response.body)["products"]

      bottoms_products = shorts_products.zip(pants_products).flatten.compact

    elsif @style == 1 # Formal

    elsif @style == 2 # Everyday

    elsif @style == 3 # Play

    elsif @style == 4 # Trendy

    else
      puts "ERROR. No style indicated"
    end

    return bottoms_products
  end

end  # end of module