class ShopStyleAPI < ApplicationController
  # Used to make GET requests 
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

  # search filter; IDs used by ShopStyle.com to identify brands
  @@brand_ids = {
    adidas:         "&fl=b14",
    ben_sherman:    "&fl=b72",
    arizona:        "&fl=b16991",
    nike:           "&fl=b422",
    puma:           "&fl=b468",
    quiksilver:     "&fl=b469",
    the_north_face: "&fl=b578",
    under_armour:   "&fl=b2184",
    oxford:         "&fl=16570",
    asics:          "&fl=b2723",
    gymboree:       "&fl=b2667",
    diesel:         "&fl=b172",
    river_island:   "&fl=b22713",
    ralph_lauren:   "&fl=b1873",
    polo_jeans:     "&fl=b461",
    childrens_place: "&fl=b3872"
  }

  @@base_url            = "http://api.shopstyle.com/api/v2/products?pid=#{PID}"
  @@base_price_filter   = "&fl=p20:"
  @@sort_by_popular     = "&sort=Popular"
  @@limit_to_50         = "&limit=50"

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
      # build url for request
      request_url = @@base_url
      request_url += @@sort_by_popular
      request_url += @@limit_to_50

      # add price filter to url
      request_url += @@base_price_filter
      request_url += SHOPSTYLE_PRICE_ID[@price].to_s

      # add size filter
      request_url += "&fl=s#{CLOTHING_SIZES[@shirt_size]}"

      # add category filter to url
      request_url += "&cat=boys-tees-and-tshirts"

      # add brand filters
      # adidas, nike, armour, and asics products
      request_url += @@brand_ids[:adidas] + @@brand_ids[:nike] + @@brand_ids[:under_armour] + @@brand_ids[:asics]

      # Send request to Shopstyle.com
      tees_response = HTTParty.get(request_url)

      # Collect the array of products
      shirt_products = JSON.parse(tees_response.body)["products"]

    elsif @style == 1 # Formal
        # build url for request
        request_url = @@base_url
        request_url += @@sort_by_popular
        request_url += @@limit_to_50

        # add price filter to url
        request_url += @@base_price_filter
        request_url += SHOPSTYLE_PRICE_ID[@price].to_s

        # add size filter
        request_url += "&fl=s#{CLOTHING_SIZES[@shirt_size]}"

        # add category filter to url
        request_url += "&cat=boys-tshirts"

        # add brand filters
        # oxford
        request_url += @@brand_ids[:oxford]

        # Send request to Shopstyle.com
        tees_response = HTTParty.get(request_url)

        # Collect the array of products
        shirt_products = JSON.parse(tees_response.body)["products"]


    elsif @style == 2 # Everyday
        # build url for request
        request_url = @@base_url
        request_url += @@sort_by_popular
        request_url += @@limit_to_50

        # add price filter to url
        request_url += @@base_price_filter
        request_url += SHOPSTYLE_PRICE_ID[@price].to_s

        # add size filter
        request_url += "&fl=s#{CLOTHING_SIZES[@shirt_size]}"

        # add category filter to url
        request_url += "&cat=boys-tees-and-tshirts"

        # add brand filters
        # gymboree
        request_url += @@brand_ids[:gymboree]

        # Send request to Shopstyle.com
        tees_response = HTTParty.get(request_url)

        # Collect the array of products
        shirt_products = JSON.parse(tees_response.body)["products"]      

    elsif @style == 3 # Play
       # build url for request
        request_url = @@base_url
        request_url += @@sort_by_popular
        request_url += @@limit_to_50

        # add price filter to url
        request_url += @@base_price_filter
        request_url += SHOPSTYLE_PRICE_ID[@price].to_s

        # add size filter
        request_url += "&fl=s#{CLOTHING_SIZES[@shirt_size]}"

        # add category filter to url
        request_url += "&cat=boys-tees-and-tshirts"

        # add brand filters
        # gymboree
        request_url += @@brand_ids[:gymboree] + @@brand_ids[:childrens_place]

        # Send request to Shopstyle.com
        tees_response = HTTParty.get(request_url)

        # Collect the array of products
        shirt_products = JSON.parse(tees_response.body)["products"]   

    elsif @style == 4 # Trendy
       # build url for request
        request_url = @@base_url
        request_url += @@sort_by_popular
        request_url += @@limit_to_50

        # add price filter to url
        request_url += @@base_price_filter
        request_url += SHOPSTYLE_PRICE_ID[@price].to_s

        # add size filter
        request_url += "&fl=s#{CLOTHING_SIZES[@shirt_size]}"

        # add category filter to url
        request_url += "&cat=boys-tees-and-tshirts"

        # add brand filters
        # diesel, ben sherman, river island
        request_url += @@brand_ids[:river_island] + @@brand_ids[:diesel] + @@brand_ids[:ben_sherman] 

        # Send request to Shopstyle.com
        tees_response = HTTParty.get(request_url)

        # Collect the array of products
        shirt_products = JSON.parse(tees_response.body)["products"]  

    else
      puts "ERROR. No style indicated"
    end

    return shirt_products
  end

  # Return Jackets API data
  # Sweaters and sweatshirts
  def jackets_API_data
    if @style == 0 # Athletic
      # build url for request
      request_url = @@base_url
      request_url += @@sort_by_popular
      request_url += @@limit_to_50

      # add price filter to url
      request_url += @@base_price_filter
      request_url += SHOPSTYLE_PRICE_ID[@price].to_s

      # add size filter
      request_url += "&fl=s#{CLOTHING_SIZES[@shirt_size]}"

      # add category filter to url
      request_url += "&cat=boys-sweatshirts"

      # add brand filters
      # adidas, nike, armour, and asics products
      request_url += @@brand_ids[:adidas] + @@brand_ids[:nike] + @@brand_ids[:under_armour] + @@brand_ids[:asics]

      # Send request to Shopstyle.com
      tees_response = HTTParty.get(request_url)

      # Collect the array of products
      jacket_products = JSON.parse(tees_response.body)["products"]

    elsif @style == 1 # Formal
        # build url for request
        request_url = @@base_url
        request_url += @@sort_by_popular
        request_url += @@limit_to_50

        # add price filter to url
        request_url += @@base_price_filter
        request_url += SHOPSTYLE_PRICE_ID[@price].to_s

        # add size filter
        request_url += "&fl=s#{CLOTHING_SIZES[@shirt_size]}"

        # add category filter to url
        request_url += "&cat=boys-sweaters"

        # add brand filters
        # oxford
        request_url += "?fts=cardigan"

        # Send request to Shopstyle.com
        tees_response = HTTParty.get(request_url)

        # Collect the array of products
        jackets_products = JSON.parse(tees_response.body)["products"]

    elsif @style == 2 # Everyday
        # build url for request
        request_url = @@base_url
        request_url += @@sort_by_popular
        request_url += @@limit_to_50

        # add price filter to url
        request_url += @@base_price_filter
        request_url += SHOPSTYLE_PRICE_ID[@price].to_s

        # add size filter
        request_url += "&fl=s#{CLOTHING_SIZES[@shirt_size]}"

        # add category filter to url
        request_url += "&cat=boys-sweaters"

        # add brand filters
        # crewneck
        request_url += "?fts=crewneck"

        # Send request to Shopstyle.com
        tees_response = HTTParty.get(request_url)

        # Collect the array of products
        jackets_products = JSON.parse(tees_response.body)["products"]

    elsif @style == 3 # Play
        # build url for request
        request_url = @@base_url
        request_url += @@sort_by_popular
        request_url += @@limit_to_50

        # add price filter to url
        request_url += @@base_price_filter
        request_url += SHOPSTYLE_PRICE_ID[@price].to_s

        # add size filter
        request_url += "&fl=s#{CLOTHING_SIZES[@shirt_size]}"

        # add category filter to url
        request_url += "&cat=boys-sweatshirts"

        # Send request to Shopstyle.com
        tees_response = HTTParty.get(request_url)

        # Collect the array of products
        jackets_products = JSON.parse(tees_response.body)["products"]

    elsif @style == 4 # Trendy
        # build url for request
        request_url = @@base_url
        request_url += @@sort_by_popular
        request_url += @@limit_to_50

        # add price filter to url
        request_url += @@base_price_filter
        request_url += SHOPSTYLE_PRICE_ID[@price].to_s

        # add size filter
        request_url += "&fl=s#{CLOTHING_SIZES[@shirt_size]}"

        # add category filter to url
        request_url += "&cat=boys-sweaters"

        # add brand filters
        # crewneck
        request_url += "?fts=cardigan"

        # Send request to Shopstyle.com
        tees_response = HTTParty.get(request_url)

        # Collect the array of products
        jackets_products = JSON.parse(tees_response.body)["products"]      

    else
      puts "ERROR. No style indicated"
    end

    return jackets_products
  end

  # Return Bottoms API data
  # Shorts, jeans, and pants
  def bottoms_API_data
        if @style == 0 # Athletic
      # build url for request
      request_url = @@base_url
      request_url += @@sort_by_popular
      request_url += @@limit_to_50

      # add price filter to url
      request_url += @@base_price_filter
      request_url += SHOPSTYLE_PRICE_ID[@price].to_s

      # add size filter
      request_url += "&fl=s#{CLOTHING_SIZES[@shirt_size]}"

      # add category filter to url
      request_url += "&cat=boys-pants"

      # add search filter to url
      request_url += "?fts=track"

      # add brand filters
      # adidas, nike, armour, and asics products
      request_url += @@brand_ids[:adidas] + @@brand_ids[:nike] + @@brand_ids[:under_armour] + @@brand_ids[:asics]

      # Send request to Shopstyle.com
      tees_response = HTTParty.get(request_url)

      # Collect the array of products
      bottoms_products = JSON.parse(tees_response.body)["products"]

    elsif @style == 1 # Formal
      # build url for request
      request_url = @@base_url
      request_url += @@sort_by_popular
      request_url += @@limit_to_50

      # add price filter to url
      request_url += @@base_price_filter
      request_url += SHOPSTYLE_PRICE_ID[@price].to_s

      # add size filter
      request_url += "&fl=s#{CLOTHING_SIZES[@shirt_size]}"

      # add category filter to url
      request_url += "&cat=boys-pants"

      # add search filter to url
      request_url += "?fts=suit-pants"

      # Send request to Shopstyle.com
      tees_response = HTTParty.get(request_url)

      # Collect the array of products
      bottoms_products = JSON.parse(tees_response.body)["products"]

    elsif @style == 2 # Everyday
      # build url for request
      request_url = @@base_url
      request_url += @@sort_by_popular
      request_url += @@limit_to_50

      # add price filter to url
      request_url += @@base_price_filter
      request_url += SHOPSTYLE_PRICE_ID[@price].to_s

      # add size filter
      request_url += "&fl=s#{CLOTHING_SIZES[@shirt_size]}"

      # add category filter to url
      request_url += "&cat=boys-pants"

      # Send request to Shopstyle.com
      tees_response = HTTParty.get(request_url)

      # Collect the array of products
      bottoms_products = JSON.parse(tees_response.body)["products"]

    elsif @style == 3 # Play
      # build url for request
      request_url = @@base_url
      request_url += @@sort_by_popular
      request_url += @@limit_to_50

      # add price filter to url
      request_url += @@base_price_filter
      request_url += SHOPSTYLE_PRICE_ID[@price].to_s

      # add size filter
      request_url += "&fl=s#{CLOTHING_SIZES[@shirt_size]}"

      # add category filter to url
      request_url += "&cat=boys-pants"

      # add brand filters
      # adidas, nike, armour, and asics products
      request_url += @@brand_ids[:gymboree]       

      # Send request to Shopstyle.com
      tees_response = HTTParty.get(request_url)

      # Collect the array of products
      bottoms_products = JSON.parse(tees_response.body)["products"]

    elsif @style == 4 # Trendy
      # build url for request
      request_url = @@base_url
      request_url += @@sort_by_popular
      request_url += @@limit_to_50

      # add price filter to url
      request_url += @@base_price_filter
      request_url += SHOPSTYLE_PRICE_ID[@price].to_s

      # add size filter
      request_url += "&fl=s#{CLOTHING_SIZES[@shirt_size]}"

      # add category filter to url
      request_url += "&cat=boys-pants"

      # add search filter to url
      # chino, twill & casual
      request_url += "?fts=chino+twill+casual"

      # Send request to Shopstyle.com
      tees_response = HTTParty.get(request_url)

      # Collect the array of products
      bottoms_products = JSON.parse(tees_response.body)["products"]

    else
      puts "ERROR. No style indicated"
    end

    return bottoms_products
  end

end  # end of module