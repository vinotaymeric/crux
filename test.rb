query =
'
SELECT *
FROM basecamps_activities
INNER JOIN basecamps_activities_itineraries ON basecamps_activities.id = basecamps_activities_itineraries.basecamps_activity_id
INNER JOIN itineraries ON basecamps_activities_itineraries.itinerary_id = itineraries.id
INNER JOIN user_activities ON user_activities.activity_id = itineraries.activity_id
WHERE user_activities.user_id = 35 AND user_activities.level = itineraries.level
GROUP BY basecamps_activities.id
ORDER BY COUNT(basecamps_activities_itineraries.itinerary_id) DESC
LIMIT 10
;
'
puts query
p "=================================="

# puts BasecampsActivity.joins(:itineraries)
#       .joins("INNER JOIN user_activities ON user_activities.activity_id = itineraries.activity_id")
#       .where(user_activities: {user_id: 35})
#       .where("user_activities.level = itineraries.level")
#       .group("basecamps_activities.id")
#       .order("COUNT(basecamps_activities_itineraries.itinerary_id) DESC")
#       .to_sql



ap BasecampsActivity.select("basecamps_activities.*, COUNT(basecamps_activities_itineraries.itinerary_id) as nb_itineraries").joins(:itineraries)
      .joins("INNER JOIN user_activities ON user_activities.activity_id = itineraries.activity_id")
      .where(user_activities: {user_id: 35})
      .where("user_activities.level = itineraries.level")
      .group("basecamps_activities.id")
      .order("COUNT(basecamps_activities_itineraries.itinerary_id) DESC")
      .limit(4)
