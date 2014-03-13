require 'spec_helper'

describe "offers/show" do
  before(:each) do
    @offer = assign(:offer, stub_model(Offer,
      :merchant_id => 1,
      :title => "Title",
      :description => "MyText",
      :url => "Url"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Title/)
    rendered.should match(/MyText/)
    rendered.should match(/Url/)
  end
end
