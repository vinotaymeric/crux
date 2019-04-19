FactoryBot.define do
  factory :invitation do
    trip { nil }
    mailed_to { "MyString" }
  end

  factory :participant do
    user { nil }
    trip { nil }
  end


  factory :itinerary do
    activity { Activity.new }
    basecamp { Basecamp.new }
    name { "Guins de l'Âne Couloir de l’étang d’Estats et Pointe de Montestaure" }
    content { "##Approche\nL'approche est la voie du Pinet qui monte au Montcalm.\nCouloir à l'aplomb de l'étang d'Estats, très rectiligne.\n2 possibilités, un couloir de gauche et un plus à droite.\nLe couloir est toujours invisible durant l'approche.\n\n##Couloir\nLe couloir sort 160 m sous le sommet du Guins de l'Âne.\n\n##Retour\nPour le retour, suivre la crête du Bang jusqu'au Port de Montestaure, puis la vallée de l'Artigue.\n" }
    difficulty { nil }
    elevation_max { 2958 }
    height_diff_up { 1760 }
    engagement_rating { nil }
    equipment_rating { nil }
    orientations { nil }
    number_of_outing { 1 }
    picture_url { nil }
    coord_long { 1.38143721 }
    coord_lat { 42.6917227 }
    level { nil }
    source_id { 1091239 }
    height_diff_down { "1760" }
    ski_rating { nil }
    hiking_rating { nil }
    score { 0.5 }
    universal_difficulty { nil }
  end

  factory :user do
    email { Faker::Internet.email }
    password { Faker::PhoneNumber.phone_number }
  end

end
