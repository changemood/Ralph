require 'rails_helper'

RSpec.describe "cards/index", type: :view do
  before(:each) do
    assign(:cards, [
      Card.create!(
        :title => "Title",
        :body => "Body"
      ),
      Card.create!(
        :title => "Title",
        :body => "Body"
      )
    ])
  end

  it "renders a list of cards" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Body".to_s, :count => 2
  end
end
