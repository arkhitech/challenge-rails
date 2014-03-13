require 'spec_helper'

describe "offers/edit" do
  before(:each) do
    @offer = assign(:offer, stub_model(Offer,
      :merchant_id => 1,
      :title => "MyString",
      :description => "MyText",
      :url => "MyString"
    ))
  end

  it "renders the edit offer form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", offer_path(@offer), "post" do
      assert_select "input#offer_merchant_id[name=?]", "offer[merchant_id]"
      assert_select "input#offer_title[name=?]", "offer[title]"
      assert_select "textarea#offer_description[name=?]", "offer[description]"
      assert_select "input#offer_url[name=?]", "offer[url]"
    end
  end
end
