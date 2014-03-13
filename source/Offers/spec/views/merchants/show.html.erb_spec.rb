require 'spec_helper'

describe "merchants/show" do
  before(:each) do
    @merchant = assign(:merchant, stub_model(Merchant,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
