json.id @current_api_user.id
json.name @current_api_user.name
json.email @current_api_user.name
json.goals @goals do |goal|
  json.id goal.id
  json.created_date goal.created_at
end

