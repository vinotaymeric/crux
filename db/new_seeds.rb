ENV['SEED_LEVEL'] = 'ACTIVITY'










#########################################################################




def seed_activities
  destroy_classic
  Itinerary.destroy_all
  Activity.destroy_all

  puts "seed_activities..."
  seed_itineraries
end

def seed_itineraries
  destroy_classic
  Itinerary.destroy_all

  puts "seed_itineraries..."
  seed_classic
end

def seed_classic
  User.destroy_all

  puts "seed_classic..."
end

def destroy_classic
  User.destroy_all
end

case ENV['SEED_LEVEL']
when 'ACTIVITY' then seed_activities
when 'ITINERARIES' then seed_itineraries
else
  seed_classic
end
