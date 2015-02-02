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
    8 => 377 # "5T"
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

  def self.product_info(product_id)
    @@response = HTTParty.get("http://api.shopstyle.com/api/v2/products/#{product_id}?pid=#{PID}")

    JSON.parse(@@response.body)    
  end  


  # Variables to build url for API call
  @request_url
  @@base_url            = "http://api.shopstyle.com/api/v2/products?pid=#{PID}"
  @@base_price_filter   = "&fl=p20:"
  @@sort_by_popular     = "&sort=Popular"
  @@limit_to_50         = "&limit=50"

  def build_partial_url(category, size)
    # build url for request
    @request_url = @@base_url
    @request_url += @@sort_by_popular
    @request_url += @@limit_to_50

    # add price filter to url
    @request_url += @@base_price_filter
    @request_url += SHOPSTYLE_PRICE_ID[@price].to_s

    # add size filter
    @request_url += "&fl=s#{CLOTHING_SIZES[size]}"

    # add category
    @request_url += category
  end

  # Initialize
  def initialize(style = 1, shirt_size = 6, pant_size = 6, jacket_size = 6, gender = "boy", price = 50)
    @style       = style.to_i
    @shirt_size  = shirt_size.to_i
    @pant_size   = pant_size.to_i
    @jacket_size = jacket_size.to_i
    @gender      = gender
    @price       = price
  end


  # Return Shirts API data
  # Polos, shirts, tees-and-tshirts
  def shirt_API_data
    if @style == 0 # Athletic
      # build parital url
      build_partial_url("&cat=boys-tees-and-tshirts", @shirt_size)

      # add brand filters
      # adidas, nike, armour, and asics products
      @request_url += @@brand_ids[:adidas] + @@brand_ids[:nike] + @@brand_ids[:under_armour] + @@brand_ids[:asics]

      # Send request to Shopstyle.com
      tees_response = HTTParty.get(@request_url)

      # Collect the array of products
      shirt_products = JSON.parse(tees_response.body)["products"]

    elsif @style == 1 # Formal   
      ##############################################
      # Search for Oxford brand in shirts
      ##############################################
      # build parital url
      build_partial_url( "&cat=boys-shirts", @shirt_size)

      # add brand filters
      # oxford
      @request_url += @@brand_ids[:oxford]

      # Send request to Shopstyle.com
      oxford_response = HTTParty.get(@request_url)

      oxford_products = JSON.parse(oxford_response.body)["products"]

      ##############################################
      # Search for 'cuff' and 'shirt' in shirts
      ##############################################
      build_partial_url( "&cat=boys-shirts", @shirt_size)

      @request_url += "&fts=shirt+cuff"

      cuff_response = HTTParty.get(@request_url)

      cuff_products = JSON.parse(cuff_response.body)["products"]

      #########################
      # Combine products
      #########################
      # Zip (interweave) products data into one array
      if !oxford_products.nil? && !cuff_products.nil?
        if oxford_products.length >= cuff_products.length
          shirt_products = oxford_products.zip(cuff_products).flatten.compact
        elsif
          shirt_products = cuff_products.zip(oxford_products).flatten.compact
        end
      elsif !oxford_products.nil?
          shirt_products = oxford_products
      else
          shirt_products = cuff_products
      end

    elsif @style == 2 # Everyday
        # build url for request
        @request_url = @@base_url
        @request_url += @@sort_by_popular
        @request_url += @@limit_to_50

        # add price filter to url
        @request_url += @@base_price_filter
        @request_url += SHOPSTYLE_PRICE_ID[@price].to_s

        # add size filter
        @request_url += "&fl=s#{CLOTHING_SIZES[@shirt_size]}"

        # add category filter to url
        @request_url += "&cat=boys-tees-and-tshirts"

        # add brand filters
        # gymboree
        @request_url += @@brand_ids[:gymboree] + @@brand_ids[:childrens_place]

        # Send request to Shopstyle.com
        tees_response = HTTParty.get(@request_url)

        # Collect the array of products
        shirt_products = JSON.parse(tees_response.body)["products"]      

    elsif @style == 3 # Trendy
       # build url for request
        @request_url = @@base_url
        @request_url += @@sort_by_popular
        @request_url += @@limit_to_50

        # add price filter to url
        @request_url += @@base_price_filter
        @request_url += SHOPSTYLE_PRICE_ID[@price].to_s

        # add size filter
        @request_url += "&fl=s#{CLOTHING_SIZES[@shirt_size]}"

        # add category filter to url
        @request_url += "&cat=boys-tees-and-tshirts"

        # add brand filters
        # diesel, ben sherman, river island
        @request_url += @@brand_ids[:river_island] + @@brand_ids[:diesel] + @@brand_ids[:ben_sherman] 

        # Send request to Shopstyle.com
        tees_response = HTTParty.get(@request_url)

        # Collect the array of products
        shirt_products = JSON.parse(tees_response.body)["products"]  

    else
      puts "ERROR. No style indicated"
    end

    return shirt_products
  end

  # Return Jackets API data
  # Sweaters and sweatshirts
  def jacket_API_data
    if @style == 0 # Athletic
      # build url for request
      @request_url = @@base_url
      @request_url += @@sort_by_popular
      @request_url += @@limit_to_50

      # add price filter to url
      @request_url += @@base_price_filter
      @request_url += SHOPSTYLE_PRICE_ID[@price].to_s

      # add size filter
      @request_url += "&fl=s#{CLOTHING_SIZES[@jacket_size]}"

      # add category filter to url
      @request_url += "&cat=boys-sweatshirts"

      # add brand filters
      # adidas, nike, armour, and asics products
      @request_url += @@brand_ids[:adidas] + @@brand_ids[:nike] + @@brand_ids[:under_armour] + @@brand_ids[:asics]

      # Send request to Shopstyle.com
      tees_response = HTTParty.get(@request_url)

      # Collect the array of products
      jackets_products = JSON.parse(tees_response.body)["products"]

    elsif @style == 1 # Formal
        # build url for request
        @request_url = @@base_url
        @request_url += @@sort_by_popular
        @request_url += @@limit_to_50

        # add price filter to url
        @request_url += @@base_price_filter
        @request_url += SHOPSTYLE_PRICE_ID[@price].to_s

        # add size filter
        @request_url += "&fl=s#{CLOTHING_SIZES[@jacket_size]}"

        # add category filter to url
        @request_url += "&cat=boys-sweaters"

        # add search query filters
        @request_url += "&fts=cardigan"

        # Send request to Shopstyle.com
        tees_response = HTTParty.get(@request_url)

        # Collect the array of products
        jackets_products = JSON.parse(tees_response.body)["products"]

    elsif @style == 2 # Everyday
        ##############################################
        # Search for 'crewneck' in sweaters
        ##############################################
        # build url for request
        @request_url = @@base_url
        @request_url += @@sort_by_popular
        @request_url += @@limit_to_50

        # add price filter to url
        @request_url += @@base_price_filter
        @request_url += SHOPSTYLE_PRICE_ID[@price].to_s

        # add size filter
        @request_url += "&fl=s#{CLOTHING_SIZES[@jacket_size]}"

        # add category filter to url
        @request_url += "&cat=boys-sweaters"

        # add brand filters
        # crewneck
        @request_url += "&fts=crewneck"

        # Send request to Shopstyle.com
        sweaters_response = HTTParty.get(@request_url)

        # Collect the array of products
        sweaters_products = JSON.parse(sweaters_response.body)["products"]

        ##############################################
        # Search for all in sweatshirts category
        ##############################################
        # build parital url
        build_partial_url( "&cat=boys-sweatshirts", @jacket_size)

        # Send request to Shopstyle.com
        sweatshirts_response = HTTParty.get(@request_url)

        # Collect the array of products
        sweatshirts_products = JSON.parse(sweatshirts_response.body)["products"]

        #########################
        # Combine products
        #########################
        # Zip (interweave) products data into one array
        if sweatshirts_products.length >= sweaters_products.length
          jackets_products = sweatshirts_products.zip(sweaters_products).flatten.compact
        else
          jackets_products = sweaters_products.zip(sweatshirts_products).flatten.compact
        end

    elsif @style == 3 # Trendy
        # build url for request
        @request_url = @@base_url
        @request_url += @@sort_by_popular
        @request_url += @@limit_to_50

        # add price filter to url
        @request_url += @@base_price_filter
        @request_url += SHOPSTYLE_PRICE_ID[@price].to_s

        # add size filter
        @request_url += "&fl=s#{CLOTHING_SIZES[@jacket_size]}"

        # add category filter to url
        @request_url += "&cat=boys-sweaters"

        # add search query filters
        # cardigan
        @request_url += "&fts=cardigan"

        # Send request to Shopstyle.com
        tees_response = HTTParty.get(@request_url)

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
      @request_url = @@base_url
      @request_url += @@sort_by_popular
      @request_url += @@limit_to_50

      # add price filter to url
      @request_url += @@base_price_filter
      @request_url += SHOPSTYLE_PRICE_ID[@price].to_s

      # add size filter
      @request_url += "&fl=s#{CLOTHING_SIZES[@pant_size]}"

      # add category filter to url
      @request_url += "&cat=boys-pants"

      # add search filter to url
      @request_url += "&fts=track"

      # add brand filters
      # adidas, nike, armour, and asics products
      @request_url += @@brand_ids[:adidas] + @@brand_ids[:nike] + @@brand_ids[:under_armour] + @@brand_ids[:asics]

      # Send request to Shopstyle.com
      tees_response = HTTParty.get(@request_url)

      # Collect the array of products
      bottoms_products = JSON.parse(tees_response.body)["products"]

    elsif @style == 1 # Formal
      # build url for request
      @request_url = @@base_url
      @request_url += @@sort_by_popular
      @request_url += @@limit_to_50

      # add price filter to url
      @request_url += @@base_price_filter
      @request_url += SHOPSTYLE_PRICE_ID[@price].to_s

      # add size filter
      @request_url += "&fl=s#{CLOTHING_SIZES[@pant_size]}"

      # add category filter to url
      @request_url += "&cat=boys-pants"

      # add search filter to url
      @request_url += "&fts=suit+pants"

      # Send request to Shopstyle.com
      tees_response = HTTParty.get(@request_url)

      # Collect the array of products
      bottoms_products = JSON.parse(tees_response.body)["products"]

    elsif @style == 2 # Everyday
      # build url for request
      @request_url = @@base_url
      @request_url += @@sort_by_popular
      @request_url += @@limit_to_50

      # add price filter to url
      @request_url += @@base_price_filter
      @request_url += SHOPSTYLE_PRICE_ID[@price].to_s

      # add size filter
      @request_url += "&fl=s#{CLOTHING_SIZES[@pant_size]}"

      # add category filter to url
      @request_url += "&cat=boys-pants"

      # Send request to Shopstyle.com
      tees_response = HTTParty.get(@request_url)

      # Collect the array of products
      bottoms_products = JSON.parse(tees_response.body)["products"]

    elsif @style == 3 # Trendy
      # build url for request
      @request_url = @@base_url
      @request_url += @@sort_by_popular
      @request_url += @@limit_to_50

      # add price filter to url
      @request_url += @@base_price_filter
      @request_url += SHOPSTYLE_PRICE_ID[@price].to_s

      # add size filter
      @request_url += "&fl=s#{CLOTHING_SIZES[@pant_size]}"

      # add category filter to url
      @request_url += "&cat=boys-pants"

      # add search filter to url
      # chino, twill & casual
      @request_url += "&fts=chino&fts=twill&fts=casual"

      # Send request to Shopstyle.com
      tees_response = HTTParty.get(@request_url)

      # Collect the array of products
      bottoms_products = JSON.parse(tees_response.body)["products"]

    else
      puts "ERROR. No style indicated"
    end
logger.debug(bottoms_products)
    return bottoms_products
  end

end  # end of module