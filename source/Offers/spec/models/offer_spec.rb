require 'spec_helper'

describe Offer do
  it 'should crawl the API and create offers in the database.' do
    Offer.crawl_and_create_via_linksearch(nil, nil, 20)
    Offer.all.size.should eql(20)
  end
  it 'should be able to crawl the API multiple times and not create duplicate offers.' do
    crawl = Offer.crawl_linksearch
    Offer.process_linksearch_response(crawl)
    total_offers = Offer.count
    Offer.process_linksearch_response(crawl)
    Offer.count.should eql(total_offers)
  end
end
