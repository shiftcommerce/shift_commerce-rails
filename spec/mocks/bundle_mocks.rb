module Mocks
  class Bundles
    BUNDLE = {
      data: {
        id: "1",
        type: "bundles",
        links: {
          self: "/testaccount/v1/bundles/1.json_api"
        },
        "attributes": {
          "updated_at": "2018-04-03T14:42:01Z",
          "created_at": "2017-11-07T12:34:43Z",
          "slug": "bundle",
          "canonical_path": "/bundles/1",
          "meta_attributes": {
              "meta_description": {
                  "value": "Crocodile 1",
                  "data_type": "textarea"
              },
              "meta_canonical_override": {
                  "value": "/",
                  "data_type": "text"
              },
              "meta_title_override": {
                  "value": "Crocodile 2",
                  "data_type": "text"
              },
              "meta_robot_tag": {
                  "value": "noindex",
                  "data_type": "radio"
              }
          },
          "name": "Bundle",
          "reference": "bundle",
          "description": ""
        },
        "relationships": {
          "asset_files": {
            "links": {
              "self": "/matalanb/v1/bundles/240/relationships/asset_files.json_api",
              "related": "/matalanb/v1/bundles/240/asset_files.json_api"
            },
            "data": [
              {
                "type": "asset_files",
                "id": "153570"
              }
            ]
          },
          "bundle_groups": {
            "links": {
              "self": "/matalanb/v1/bundles/240/relationships/bundle_groups.json_api",
              "related": "/matalanb/v1/bundles/240/bundle_groups.json_api"
            }
          }
        }
      },
      "included": [
        {
            "id": "153570",
            "type": "asset_files",
            "links": {
                "self": "/matalanb/v1/asset_files/153570.json_api"
            },
            "attributes": {
                "meta_attributes": {},
                "updated_at": Time.now,
                "created_at": Time.now,
                "deleted_at": "",
                "name": "",
                "reference": "e8eeaae2-ed10-42ef-8771-4d41e5b79176",
                "asset_file": "1510654205.45299-MATALAN-EP24-Alesha_014_1_.jpg",
                "file_content_filename": "MATALAN-EP24-Alesha_014_1_.jpg",
                "file_content_content_type": "image/jpeg",
                "file_content_size": 11920802,
                "image_height": 5418,
                "image_width": 3612,
                "s3_url": "https://production-matalanb-files.s3-eu-west-1.amazonaws.com/uploads/asset_file/asset_file/153570/1510654205.45299-MATALAN-EP24-Alesha_014_1_.jpg",
                "canonical_path": "https://production-matalanb-files.s3-eu-west-1.amazonaws.com/uploads/asset_file/asset_file/153570/1510654205.45299-MATALAN-EP24-Alesha_014_1_.jpg"
            },
            "relationships": {
                "asset_folder": {
                    "links": {
                        "self": "/matalanb/v1/asset_files/153570/relationships/asset_folder.json_api",
                        "related": "/matalanb/v1/asset_files/153570/asset_folder.json_api"
                    }
                }
            }
        }
      ],
      links: {
        self: "/testaccount/v1/bundles/1.json_api"
      }
    }.to_json.freeze

    TEMPLATE_DEFINITION = {
      data: [],
      links: {
        self: "/testaccount/v1/bundles/1/template_definition.json_api"
      }
    }.to_json.freeze
  end
end
