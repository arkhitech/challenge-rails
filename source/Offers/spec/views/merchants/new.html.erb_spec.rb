require 'spec_helper'

describe "merchants/new" do
  before(:each) do
    assign(:merchant, stub_model(Merchant,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new merchant form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", merchants_path, "post" do
      assert_select "input#merchant_name[name=?]", "merchant[name]"
    end
  end
end
