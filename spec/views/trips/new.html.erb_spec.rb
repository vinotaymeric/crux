require "rails_helper"

RSpec.describe "rendering text directly" do
  it "displays the given text" do
    assign(:trip, Trip.new)
    render
    expect(rendered).to match /Sélectionne une ou des activités/
  end
end
