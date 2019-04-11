require 'rails_helper'

RSpec.describe Itinerary, type: :model do
  it { should validate_presence_of(:basecamp) }
  it { should validate_presence_of(:activity) }
  it { should allow_value('TD').for(:difficulty) }
end
