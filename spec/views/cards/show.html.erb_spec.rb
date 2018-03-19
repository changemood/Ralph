require 'rails_helper'

RSpec.describe "cards/show", type: :view do
  before(:each) do
    @card = assign(:card, Card.create!(
      :title => "Title",
      :body => "Body"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Body/)
  end
end
