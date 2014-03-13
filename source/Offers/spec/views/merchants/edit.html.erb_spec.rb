require 'spec_helper'

describe "merchants/edit" do
  before(:each) do
    @merchant = assign(:merchant, stub_model(Merchant,
      :name => "MyString"
    ))
  end

  it "renders the edit merchant form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", merchant_path(@merchant), "post" do
      assert_select "input#merchant_name[name=?]", "merchant[name]"
    end
  end
end
