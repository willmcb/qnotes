json.array! @notes do |note|
  json.user note.user.username
  json.collection note.collection.name
  json.title note.title
  json.body note.body
  json.tags note.tags do |tag|
    json.name tag.name
  end
end
