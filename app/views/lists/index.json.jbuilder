json.lists @lists do |json, list|
  json.name list.name
  json.link list_url(list, only_path: false)
  json.items_link list_items_url(list, only_path: false)
end
