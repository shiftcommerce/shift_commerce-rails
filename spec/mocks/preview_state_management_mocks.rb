module Mocks
  class PreviewStateManagement
    STANDARD_RESPONSE = {
      data: {
        id: "1",
        type: "static_pages",
        links: {
          self: "/testaccount/v1/static_pages/1.json_api"
        },
        attributes: {
          "meta_attributes": {
            "static_content": {
              "value": "Published",
              "data_type": "textarea"
            }
          },
          body_content: "",
          published: true
        }
      },
      links: {
        self: "/testaccount/v1/static_pages/1.json_api"
      }
    }.to_json.freeze

    PREVIEW_RESPONSE = {
      data: {
        id: "1",
        type: "static_pages",
        links: {
          self: "/testaccount/v1/static_pages/1.json_api"
        },
        attributes: {
          "meta_attributes": {
            "static_content": {
              "value": "Preview",
              "data_type": "textarea"
            }
          },
          body_content: "",
          published: true
        }
      },
      links: {
        self: "/testaccount/v1/static_pages/1.json_api?preview=true"
      }
    }.to_json.freeze
  end
end
