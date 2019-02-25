class TripsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :index, :new, :create]


    def new
    end

    def show
    end

    def index
    end

   def create
   end

   def update
   end

   def edit
   end

end
