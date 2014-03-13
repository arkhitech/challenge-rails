require 'spec_helper'

describe "offers/index" do
  before(:each) do
    assign(:offers, [
      stub_model(Offer,
        :merchant_id => 1,
        :title => "Title",
        :description => "MyText",
        :url => "Url"
      ),
      stub_model(Offer,
        :merchant_id => 1,
        :title => "Title",
        :description => "MyText",
        :url => "Url"
      )
    ])
  end

  it "renders a list of offers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Url".to_s, :count => 2
  end
end
