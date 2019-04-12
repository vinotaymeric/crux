FactoryBot.define do

  factory :itinerary do
    activity { Activity.new }
    basecamp { Basecamp.new }
    name { "Guins de l'Âne Couloir de l’étang d’Estats et Pointe de Montestaure" }
  end

end
