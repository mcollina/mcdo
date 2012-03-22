json.items @list.items do |json, item|
  json.name item.name
end
json.list_link list_url(@list, only_path: false)
