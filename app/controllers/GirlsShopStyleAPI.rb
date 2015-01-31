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
  def initialize(style = 2, shirt_size = 7, pant_size = 7, jacket_size = 7, gender = "female", price = 50)
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
      ##########################################
      # API call for Tees and Tshirts Category
      # Search by brands: 'adidas' and 'nike'
      ##########################################
      # build partial url
      build_partial_url("&cat=girls-tees-and-tshirts")

      # add brand filters
      @request_url += @@brand_ids[:adidas] + @@brand_ids[:nike] 

      # Send request to Shopstyle.com
      tees_by_brand_response = HTTParty.get(@request_url)

      # Collect products
      tees_by_brand_products = JSON.parse(tees_by_brand_response.body)["products"]

      ##########################################
      # API call for Tees and Tshirt category
      # Search by query: 'active'
      ##########################################
      # build partial url
      build_partial_url("&cat=girls-tees-and-tshirts")

      # add search query filter
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
      # Search by query: 'sequin,' 'formal,' 'sparkling,' and 'lace'
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
      # Search by brand: 'Aletta'
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
      # Search by query: "tunic"
      ##########################################
      # build partial url
      build_partial_url("&cat=girls-shirts")

      # add search query filter
      @request_url += "&fts=tunic"

      # Send request to Shopstyle.com
      shirts_by_query_response = HTTParty.get(@request_url)

      # Collect products
      shirts_by_query_products = JSON.parse(shirts_by_query_response.body)["products"]

      ##########################################
      # API call for Polos category.
      # Search all
      ##########################################
      # build partial url
      build_partial_url("&cat=girls-polos")

      # Send request to Shopstyle.com
      polos_by_query_response = HTTParty.get(@request_url)

      # Collect products
      polos_by_query_products = JSON.parse(polos_by_query_response.body)["products"]

      ##########################################
      # API call for Tees and Tshirts category.
      # Search all
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
      # Search by query: 'denim' and 'blouse'
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
      # Search by query: 'graphic'
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

  ###########################################
  ###########################################
  # Return Jackets API data
  ###########################################
  ########################################### 
  # Sweaters and sweatshirts categories
  def jackets_API_data
    if @style == 0 # Athletic
      #########################################
      # API call for Sweatshirts category.
      # Search with 'active' and 'hoodies' queries
      #########################################
      build_partial_url("&cat=girls-sweatshirts")

      @request_url += '&fts=active&fts=hoodies'

      sweatshirts_by_query_response = HTTParty.get(@request_url)

      sweatshirts_by_query_products = JSON.parse(sweatshirts_by_query_response.body)["products"]

      jackets_products = sweatshirts_by_query_products

    elsif @style == 1 # Formal
      #########################################
      # API call for Sweaters category.
      # Search with 'cardigan' query
      #########################################
      build_partial_url("&cat=girls-sweaters")

      @request_url += '&fts=cardigan'

      sweaters_by_query_response = HTTParty.get(@request_url)

      sweaters_by_query_products = JSON.parse(sweaters_by_query_response.body)["products"]

      jackets_products = sweaters_by_query_products

    elsif @style == 2 # Everyday
      #########################################
      # API call for Sweaters category.
      # Search with no query
      #########################################
      build_partial_url("&cat=girls-sweaters")

      sweaters_response = HTTParty.get(@request_url)

      sweaters_products = JSON.parse(sweaters_response.body)["products"]

      #########################################
      # API call for Sweatshirts category.
      # Search with no query
      #########################################
      build_partial_url("&cat=girls-sweatshirts")

      sweatshirts_response = HTTParty.get(@request_url)

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
      build_partial_url("&cat=girls-sweaters")

      @request_url += '&fts=print'

      sweaters_by_query_response = HTTParty.get(@request_url)

      sweaters_by_query_products = JSON.parse(sweaters_by_query_response.body)["products"]

      jackets_products = sweaters_by_query_products

    else
      puts "ERROR. No style indicated"
    end

    # Return an array of filtered products
    return jackets_products
  end

  # Return Bottoms API data
  # Shorts, skirts, jeans, and pants categories used
  def bottoms_API_data
    if @style == 0 # Athletic
      
      #########################################
      # API call for Pants category.
      # Search with 'active,' 'training,' 
      # 'yoga,' 'athletic' query
      #########################################
      build_partial_url("&cat=girls-pants")

      @request_url += '&fts=active&fts=training&fts=yoga&fts=athletic'

      pants_by_query_response = HTTParty.get(@request_url)

      pants_by_query_products = JSON.parse(pants_by_query_response.body)["products"]

      #########################################
      # API call for Shorts category.
      # Search with 'active' and 'run' query
      #########################################
      build_partial_url("&cat=girls-shorts")

      @request_url += '&fts=active&fts=run'

      shorts_by_query_response = HTTParty.get(@request_url)

      shorts_by_query_products = JSON.parse(shorts_by_query_response.body)["products"]

      # Merge two products into one array
      bottoms_products = shorts_by_query_products.zip(pants_by_query_products).flatten.compact

    elsif @style == 1 # Formal
      # None returned

    elsif @style == 2 # Everyday
      
      #########################################
      # API call for Jeans category.
      # Search all. Limit output to 15
      #########################################
      build_partial_url("&cat=girls-jeans")

      @request_url.sub! 'limit=50', 'limit=15'

      jeans_response = HTTParty.get(@request_url)

      jeans_products = JSON.parse(jeans_response.body)["products"]

      #########################################
      # API call for Pants category.
      # Search all. Limit output to 15
      #########################################
      build_partial_url("&cat=girls-pants")

      @request_url.sub! 'limit=50', 'limit=15'

      pants_response = HTTParty.get(@request_url)

      pants_products = JSON.parse(pants_response.body)["products"]

      #########################################
      # API call for Shorts category.
      # Search query 'denim'. Limit output to 15
      #########################################
      build_partial_url("&cat=girls-shorts")

      @request_url.sub! 'limit=50', 'limit=15'

      @request_url += '&fts=denim'

      shorts_response = HTTParty.get(@request_url)

      shorts_products = JSON.parse(shorts_response.body)["products"]

      #########################################
      # API call for Skirts category.
      # Search all. Limit output to 15
      #########################################
      build_partial_url("&cat=girls-skirts")

      @request_url.sub! 'limit=50', 'limit=15'

      skirts_response = HTTParty.get(@request_url)

      skirts_products = JSON.parse(skirts_response.body)["products"]

      # Merge products
      bottoms_products = jeans_products.zip(pants_products).flatten.compact
      bottoms_products = bottoms_products.zip(shorts_products).flatten.compact
      bottoms_products = bottoms_products.zip(skirts_products).flatten.compact

    elsif @style == 3 # Play

    elsif @style == 4 # Trendy
           
      #########################################
      # API call for Jeans category.
      # Search all. Limit output to 15
      #########################################
      build_partial_url("&cat=girls-jeans")

      @request_url.sub! 'limit=50', 'limit=15'

      jeans_response = HTTParty.get(@request_url)

      jeans_products = JSON.parse(jeans_response.body)["products"]

      ############################################################
      # API call for Pants category.
      # Search by 'ponte' and 'leggings' query. Limit output to 15
      #############################################################
      build_partial_url("&cat=girls-pants")

      @request_url.sub! 'limit=50', 'limit=15'

      @request_url += '&fts=ponte&fts=leggings'

      pants_response = HTTParty.get(@request_url)

      pants_products = JSON.parse(pants_response.body)["products"]

      #########################################
      # API call for Shorts category.
      # Search all. Limit output to 15
      #########################################
      build_partial_url("&cat=girls-shorts")

      @request_url.sub! 'limit=50', 'limit=15'

      shorts_response = HTTParty.get(@request_url)

      shorts_products = JSON.parse(shorts_response.body)["products"]

      #########################################
      # API call for Skirts category.
      # Search all. Limit output to 15
      #########################################
      build_partial_url("&cat=girls-skirts")

      @request_url.sub! 'limit=50', 'limit=15'

      @request_url += '&fts=tulle&fts=tiered&&fts=tutu'

      skirts_response = HTTParty.get(@request_url)

      skirts_products = JSON.parse(skirts_response.body)["products"]

      # Merge products
      bottoms_products = jeans_products.zip(pants_products).flatten.compact
      bottoms_products = bottoms_products.zip(shorts_products).flatten.compact
      bottoms_products = bottoms_products.zip(skirts_products).flatten.compact

    else
      puts "ERROR. No style indicated"
    end

    return bottoms_products
  end
end  # end of module