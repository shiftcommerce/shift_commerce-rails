module Mocks
  class StaticPages
    STATIC_PAGE = {
      data: {
        id: "1",
        type: "static_pages",
        links: {
          self: "/testaccount/v1/static_pages/1.json_api"
        },
        attributes: {
          meta_attributes: {},
          template_attributes: {},
          updated_at: Time.now,
          created_at: Time.now,
          title: "Static Page",
          slug: "static-page",
          reference: "static-page",
          body_content: "Test",
          published: true
        },
        relationships: {
          template_definition: {
            links: {
              self: "/testaccount/v1/static_pages/1/relationships/template_definition.json_api",
              related: "/testaccount/v1/static_pages/1/template_definition.json_api"
            }
          },
        }
      },
      links: {
        self: "/testaccount/v1/static_pages/1.json_api?preview=true"
      }
    }.to_json.freeze
  end
end
