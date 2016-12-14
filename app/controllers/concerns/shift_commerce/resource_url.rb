#
# ResourceUrl
#
# Responsibility: Includes helper methods for generating a resource's url using it's slug.
#
module ShiftCommerce
  module ResourceUrl
    extend ActiveSupport::Concern

    private

    def generate_url_for(path, params = false)
      @params ||= generate_params_from_string(params) if params.is_a? String
      if @params.present?
        @params.delete_if { |k,v| k == "action".freeze || k == "controller".freeze || k == "id".freeze || k == "slug_parts".freeze }
        @stringified_params ||= @params.inject([]) { |s, (key, value)| s << "#{key}=#{URI.escape(value.to_s)}" }.join("&".freeze)
      end
      path = "/#{path}" if path[0] != "/".freeze
      [path, @stringified_params].compact.join('?'.freeze)
    end

    def generate_absolute_url_for(path, params = false, base_url = request.base_url)
      generate_url_for(path, params)[1..-1].prepend("#{base_url}/")
    end

    def generate_params_from_string(string)
      @options ||= string.split('&'.freeze)
      hash = @options.inject({}) do |hash, option|
        key,value = option.split('='.freeze)
        hash[key] = value
        hash
      end
    end
  end
end
