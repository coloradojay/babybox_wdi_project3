# working file for Girls api call
class GirlsShopStyleAPI < ApplicationController
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
    polo_jeans:     "&fl=b461"
  }

  @request_url

  @@base_url            = "http://api.shopstyle.com/api/v2/products?pid=#{PID}"
  @@base_price_filter   = "&fl=p20:"
  @@sort_by_popular     = "&sort=Popular"
  @@limit_to_50         = "&limit=50"

  def build_partial_url(category)
    # build url for request
    @request_url = @@base_url
    @request_url += @@sort_by_popular
    @request_url += @@limit_to_50

    # add price filter to url
    @request_url += @@base_price_filter
    @request_url += SHOPSTYLE_PRICE_ID[@price].to_s

    # add size filter
    @request_url += "&fl=s#{CLOTHING_SIZES[@shirt_size]}"

    # add category
    @request_url += category
  end

  # Initialize
  def initialize(style = 2, shirt_size = 6, pant_size = 6, jacket_size = 6, gender = "female", price = 50)
    @style       = style
    @shirt_size  = shirt_size
    @pant_size   = pant_size
    @jacket_size = jacket_size
    @gender      = gender
    @price       = price
  end


  #################################
  # Methods(3) for API hits
  #   shirt_API_data()
  #   jackets_API_data()
  #   bottoms_API_data()
  #################################
  # Return Shirts API data
  # Polos, shirts, tees-and-tshirts
  def shirt_API_data
    if @style == 0 # Athletic
      #####################
      # API call for brands
      #####################
      # build partial url
      build_partial_url("&cat=girls-tees-and-tshirts")

      # add brand filters
      # adidas, nike, armour, and asics products
      @request_url += @@brand_ids[:adidas] + @@brand_ids[:nike] 

      # Send request to Shopstyle.com
      tees_by_brand_response = HTTParty.get(@request_url)

      # Collect products
      tees_by_brand_products = JSON.parse(tees_by_brand_response.body)["products"]

      ##########################################
      # API call for 'active' search term
      ##########################################
      # build partial url
      build_partial_url("&cat=girls-tees-and-tshirts")

      # add search query filter
      # query = 'active'
      @request_url += "&fts=active"

      # Send request to Shopstyle.com
      tees_by_query_response = HTTParty.get(@request_url)

      # Collect products
      tees_by_query_products = JSON.parse(tees_by_query_response.body)["products"]

      #########################
      # Combine products
      #########################
      # Zip (interweave) products data into one array
      shirt_products = tees_by_brand_products.zip(tees_by_query_products).flatten.compact

    elsif @style == 1 # Formal
      ##################################################
      # API call for Dress category
      # with 'sequin,' 'formal,' 'sparkling,' and 'lace' query
      ##################################################
      # build partial url
      build_partial_url("&cat=girls-dresses")

      # add search query filter
      @request_url += "&fts=sequin&fts=formal&fts=sparkling&fts=lace"

      # Send request to Shopstyle.com
      dresses_by_query_response = HTTParty.get(@request_url)

      # Collect products
      dresses_by_query_products = JSON.parse(dresses_by_query_response.body)["products"]

      ##################################################
      # API call for Dress category
      # with brand filter 'Aletta'
      ##################################################
      # build partial url
      build_partial_url("&cat=girls-dresses")

      # add brand filter
      @request_url += "&fl=b2582"

      # Send request to Shopstyle.com
      dresses_by_brand_response = HTTParty.get(@request_url)

      # Collect products
      dresses_by_brand_products = JSON.parse(dresses_by_brand_response.body)["products"]

      #########################
      # Combine products
      #########################
      # Zip (interweave) products data into one array
      shirt_products = dresses_by_brand_products.zip(dresses_by_query_products).flatten.compact
      
    elsif @style == 2 # Everyday
      ##########################################
      # API call for Shirts and Blouses category
      # with query "tunic"
      ##########################################
      # build partial url
      build_partial_url("&cat=girls-shirts")

      # add search query filter
      # query = 'active'
      @request_url += "&fts=tunic"

      # Send request to Shopstyle.com
      shirts_by_query_response = HTTParty.get(@request_url)

      # Collect products
      shirts_by_query_products = JSON.parse(shirts_by_query_response.body)["products"]

      ##########################################
      # API call for Polos category.
      # Search without any filters
      ##########################################
      # build partial url
      build_partial_url("&cat=girls-polos")

      # Send request to Shopstyle.com
      polos_by_query_response = HTTParty.get(@request_url)

      # Collect products
      polos_by_query_products = JSON.parse(polos_by_query_response.body)["products"]

      ##########################################
      # API call for Tees and Tshirts category.
      # Search without any filters
      ##########################################
      # build partial url
      build_partial_url("&cat=girls-tees-and-tshirts")

      # Send request to Shopstyle.com
      tees_response = HTTParty.get(@request_url)

      # Collect products
      tees_products = JSON.parse(tees_response.body)["products"]

      #########################
      # Combine products
      #########################
      # Zip (interweave) products data into one array
      shirt_products = shirts_by_query_products.zip(polos_by_query_products).flatten.compact
      shirt_products = shirt_products.zip(tees_products).flatten.compact

    elsif @style == 3 # Play

    elsif @style == 4 # Trendy
      ##########################################
      # API call for Shirts and Blouses category.
      # Search with 'denim' and 'blouse' queries
      ##########################################
      # build partial url
      build_partial_url("&cat=girls-shirts")

      # Add search query filter
      @request_url += '&fts=denim&fts=blouse'

      # Send request to Shopstyle.com
      shirts_by_query_response = HTTParty.get(@request_url)

      # Collect products
      shirts_by_query_products = JSON.parse(shirts_by_query_response.body)["products"]

      ##########################################
      # API call for Tees and Tshirts category.
      # Search with 'graphic' query
      ##########################################
      # build partial url
      build_partial_url("&cat=girls-tees-and-tshirts")

      # Add search query filter
      @request_url += '&fts=graphic'

      # Send request to Shopstyle.com
      tees_by_query_response = HTTParty.get(@request_url)

      # Collect products
      tees_by_query_products = JSON.parse(tees_by_query_response.body)["products"]

      #########################
      # Combine products
      #########################
      # Zip (interweave) products data into one array
      shirt_products = shirts_by_query_products.zip(tees_by_query_products).flatten.compact
    else
      puts "ERROR. No style indicated"
    end

    return shirt_products
  end

  # Return Jackets API data
  # Sweaters and sweatshirts
  def jackets_API_data
    if @style == 0 # Athletic
      #########################################
      # API call for Sweatshirts category.
      # Search with 'active' and 'hoodies' queries
      #########################################
      # build partial url
      build_partial_url("&cat=girls-sweatshirts")

      # Add search query filter
      @request_url += '&fts=active&fts=hoodies'

      # Send request to Shopstyle.com
      sweatshirts_by_query_response = HTTParty.get(@request_url)

      # Collect products
      sweatshirts_by_query_products = JSON.parse(sweatshirts_by_query_response.body)["products"]

      jackets_products = sweatshirts_by_query_products

    elsif @style == 1 # Formal
      #########################################
      # API call for Sweaters category.
      # Search with 'cardigan' query
      #########################################
      # build partial url
      build_partial_url("&cat=girls-sweaters")

      # Add search query filter
      @request_url += '&fts=cardigan'

      # Send request to Shopstyle.com
      sweaters_by_query_response = HTTParty.get(@request_url)

      # Collect products
      sweaters_by_query_products = JSON.parse(sweaters_by_query_response.body)["products"]

      jackets_products = sweaters_by_query_products

    elsif @style == 2 # Everyday
      #########################################
      # API call for Sweaters category.
      # Search with no query
      #########################################
      # build partial url
      build_partial_url("&cat=girls-sweaters")

      # Send request to Shopstyle.com
      sweaters_response = HTTParty.get(@request_url)

      # Collect products
      sweaters_products = JSON.parse(sweaters_response.body)["products"]

      #########################################
      # API call for Sweatshirts category.
      # Search with no query
      #########################################
      # build partial url
      build_partial_url("&cat=girls-sweatshirts")

      # Send request to Shopstyle.com
      sweatshirts_response = HTTParty.get(@request_url)

      # Collect products
      sweatshirts_products = JSON.parse(sweatshirts_response.body)["products"]

      #########################
      # Combine products
      #########################
      # Zip (interweave) products data into one array
      jackets_products = sweatshirts_products.zip(sweaters_products).flatten.compact

    elsif @style == 3 # Play

    elsif @style == 4 # Trendy
      #########################################
      # API call for Sweaters category.
      # Search with 'print' query
      #########################################
      # build partial url
      build_partial_url("&cat=girls-sweaters")

      # Add search query filter
      @request_url += '&fts=print'

      # Send request to Shopstyle.com
      sweaters_by_query_response = HTTParty.get(@request_url)

      # Collect products
      sweaters_by_query_products = JSON.parse(sweaters_by_query_response.body)["products"]

      jackets_products = sweaters_by_query_products

    else
      puts "ERROR. No style indicated"
    end

    # Return an array of filtered products
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