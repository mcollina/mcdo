json.lists @lists do |json, list|
  json.name list.name
  json.link list_url(list, only_path: false)
end
