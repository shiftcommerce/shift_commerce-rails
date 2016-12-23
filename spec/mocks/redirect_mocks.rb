module Mocks
  class Redirects
    EXACT_REDIRECT = {
      data: {
        "id": "1",
        "type": "redirects",
        "links": {
          "self": "/testaccount/v1/redirects/1.json_api"
        },
        "attributes": {
          "name": "Redirect Name",
          "status_code": 301,
          "priority": 0,
          "source_type": "exact",
          "source_path": "/",
          "destination_path": "/somewhere_else",
        }
      },
      meta: {
        total_entries: 1,
        page_count: 1
      },
      links: []
    }.to_json.freeze

    EMPTY_REDIRECT = {
      data: [],
      meta: {
        total_entries: 0,
        page_count: 0
      },
      links: []
    }.to_json.freeze
  end
end
