SELECT basecamps_activities.activity_id,
  basecamps_activities.basecamp_id, basecamps_activities.id, COUNT(basecamps_activities_itineraries.itinerary_id)
FROM basecamps_activities
INNER JOIN basecamps_activities_itineraries ON basecamps_activities.id = basecamps_activities_itineraries.basecamps_activity_id
INNER JOIN itineraries ON basecamps_activities_itineraries.itinerary_id = itineraries.id
INNER JOIN user_activities ON user_activities.activity_id = itineraries.activity_id
WHERE user_activities.user_id = 35 AND user_activities.level = itineraries.level
GROUP BY basecamps_activities.id
ORDER BY COUNT(basecamps_activities_itineraries.itinerary_id) DESC
;
