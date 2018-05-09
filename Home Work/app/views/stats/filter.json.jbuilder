json.array! @acts do |action|
  json.username action.user.name
  json.date action.date
  json.name action.name
  json.category action.category.name
  json.value action.value
end