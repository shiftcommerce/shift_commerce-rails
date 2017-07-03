# Sets a header on responses telling the CDN to push critical (<head>) assets
# along with the response
module ShiftCommerce
  module AssetPush
    extend ActiveSupport::Concern

    included do
      before_action :add_preload_headers, if: -> { request.get? }
    end

    private

    # appends a Link header for each asset that's due to be pushed
    def add_preload_headers
      response.headers['Link'] ||= []
      Array(push_assets).each do |path|
        response.headers['Link'].push("<#{view_context.asset_path(path)}>; rel=preload; as=#{asset_type(path)}")
      end
    end

    # these should only be non-async assets used in <head>
    def push_assets
      raise NotImplementedError, "to use asset push, you must define #push_assets"
    end

    # determines the asset type using its extension
    def asset_type(path)
      file_extention = File.extname(path)
      case file_extention
      when ".js"  then "script"
      when ".css" then "style"
      else return
      end
    end
  end
end
