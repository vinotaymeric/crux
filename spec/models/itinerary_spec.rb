require 'rails_helper'

RSpec.describe Itinerary, type: :model do

  before(:all) do
    @itinerary = FactoryBot.build(:itinerary)
  end

  it "is valid with valid attributes" do
    expect(@itinerary).to be_valid
  end

  it { should validate_presence_of(:basecamp) }
  it { should validate_presence_of(:activity) }
  it { should allow_value('TD').for(:difficulty) }

  it "should have a short name, valid, less than 45 char" do
    expect(@itinerary.short_name.length).to be <= 45
  end
end
