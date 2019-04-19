require 'rails_helper'

RSpec.describe Participant, type: :model do

  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:trip) }
end
