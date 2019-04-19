require 'rails_helper'

RSpec.describe TripsController do

  before(:all) do
    Rails.application.load_seed
    @trip = FactoryBot.create(:trip)
  end

  describe "GET index" do
    it "has a 200 status code" do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe "GET new" do
    it "has a 200 status code" do
      get :new
      expect(response.status).to eq(200)
    end
  end

  # describe "GET show/:id" do
  #   it "has a 200 status code" do
  #     get :show, params: { id: @trip.id }
  #     expect(response.status).to eq(200)
  #   end
  # end
end
