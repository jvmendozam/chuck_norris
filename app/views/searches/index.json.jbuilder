json.set! :data do
  json.array! @searches do |search|
    json.partial! 'searches/search', search: search
    json.url  "
              #{link_to 'Show', search }
              #{link_to 'Edit', edit_search_path(search)}
              #{link_to 'Destroy', search, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end