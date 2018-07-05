json.array! @roots do |root|
  json.merge! root.as_sortable_tree_json
end