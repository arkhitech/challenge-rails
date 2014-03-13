require 'spec_helper'

describe "offers/new" do
  before(:each) do
    assign(:offer, stub_model(Offer,
      :merchant_id => 1,
      :title => "MyString",
      :description => "MyText",
      :url => "MyString"
    ).as_new_record)
  end

  it "renders new offer form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", offers_path, "post" do
      assert_select "input#offer_merchant_id[name=?]", "offer[merchant_id]"
      assert_select "input#offer_title[name=?]", "offer[title]"
      assert_select "textarea#offer_description[name=?]", "offer[description]"
      assert_select "input#offer_url[name=?]", "offer[url]"
    end
  end
end
