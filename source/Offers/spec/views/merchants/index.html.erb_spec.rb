require 'spec_helper'

describe "merchants/index" do
  before(:each) do
    assign(:merchants, [
      stub_model(Merchant,
        :name => "Name"
      ),
      stub_model(Merchant,
        :name => "Name"
      )
    ])
  end

  it "renders a list of merchants" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
