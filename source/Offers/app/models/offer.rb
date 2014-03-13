class Offer < ActiveRecord::Base
  require 'net/http'
  API_KEY='00853007dc51e2bd4d3d139cbd8d387b1c3d9cae8afd4cef2a8c5add85d2808d34cf17e3303197fc22fbbd5ec4467b40c244f99035561789932878bdcf14ef7b67/1faecb4fe7d2ce415f7418e7267ef71a42b5d0f7934607e6d1389455cf3b715b70892b0ec2da8136c8bff4ab91ebcfec466caf8eacfd7d16a4ffe42e935cc0a1'
  API_URL='https://linksearch.api.cj.com/v2/link-search'
  WEBSITE_ID = 5742006
  RECORDS_PER_PAGE = 20
  
  belongs_to :merchant
  validates :link_id, uniqueness: true
  class << self
    def crawl_linksearch(api_url = API_URL, website_id = WEBSITE_ID, records_per_page = RECORDS_PER_PAGE)
      api_url ||= API_URL
      website_id ||= WEBSITE_ID
      records_per_page ||= RECORDS_PER_PAGE
      
      uri = URI.parse(api_url)
      params = { 'website-id' => website_id, 'records-per-page' => records_per_page }
      uri.query = URI.encode_www_form(params)
      
      response = nil
      Net::HTTP.start(uri.host, uri.port,
        :use_ssl => uri.scheme == 'https') do |http|
        request = Net::HTTP::Get.new(uri)
        request['authorization'] = API_KEY

        response = http.request request
      end  
      if response.is_a?(Net::HTTPSuccess)
        response.body 
      else
        nil #some error occurred
      end
    end
    
    def process_linksearch_response(linksearch_response)
      return nil unless linksearch_response

      response_hash = Hash.from_xml(linksearch_response).deep_symbolize_keys
      records = response_hash[:cj_api][:links][:link]
      Offer.transaction do 
        records.each do |record|
          Offer.create_from_linksearch(record.deep_symbolize_keys)
        end
      end      
    end
    # Linksearch result:
    # {"advertiser_id"=>"4034381", "advertiser_name"=>"BornPrettyStore.com",
    #  "category"=>"cosmetics", "click_commission"=>"0.0", "creative_height"=>"125", 
    #  "creative_width"=>"125", "language"=>"en", "lead_commission"=>nil, 
    #  "link_code_html"=>nil, "link_code_javascript"=>nil, 
    #  "description"=>"BornPrettyStore Liner Polish with Glitter from 0.99 USD", 
    #  "destination"=>"http://www.bornprettystore.com/beauty-nail-c-268.html", 
    #  "link_id"=>"11423574", "link_name"=>"BornPrettyStore Liner Polish with Glitter from 0.99 USD", 
    #  "link_type"=>"Banner", "performance_incentive"=>"true", "promotion_end_date"=>nil, 
    #  "promotion_start_date"=>nil, "promotion_type"=>nil, "relationship_status"=>"notjoined", 
    #  "sale_commission"=>"10.00% - 15.00%", "seven_day_epc"=>"N/A", "three_month_epc"=>"0.00"}    
    def create_from_linksearch(linksearch_record)
      @@merchants ||= {}
      merchant = @@merchants[linksearch_record[:advertiser_id]] ||= 
        Merchant.find_or_create_by(advertiser_id: linksearch_record[:advertiser_id], 
        name: linksearch_record[:advertiser_name])
      
      merchant.offers.find_or_create_by(link_id: linksearch_record[:link_id], title: linksearch_record[:link_name], description: linksearch_record[:description], 
        url: linksearch_record[:destination], expires_at: linksearch_record[:promotion_end_date])
    end
    
    def crawl_and_create_via_linksearch(api_url = API_URL, website_id = WEBSITE_ID, records_per_page = RECORDS_PER_PAGE)
      api_url ||= API_URL
      website_id ||= WEBSITE_ID
      records_per_page ||= RECORDS_PER_PAGE
      
      process_linksearch_response(crawl_linksearch(api_url, website_id, records_per_page))
    end
  end
end
