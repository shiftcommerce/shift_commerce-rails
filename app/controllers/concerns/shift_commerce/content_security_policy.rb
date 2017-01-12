#
# This module manages the Content-Security-Policy header used to prevent various
# cross-domain / CSRF attacks
#
module ShiftCommerce
  module ContentSecurityPolicy
    extend ActiveSupport::Concern

    DEFAULT_POLICY = {
      'default-src': ["'self'"],
      'base-uri': ["'self'"],
      'object-src': ["'none'"],
      'img-src': ["'self'", 'data:'],
      'script-src': ["'self'"],
      'style-src': ["'self'"],
      'font-src': ["'self'"],
      'child-src': ["'none'"],
      'frame-ancestors': ["'none'"]
    }.with_indifferent_access.freeze

    included do
      after_action :apply_content_security_policy
    end

    private

    # Applies the Content-Security-Policy header to the HTTP response
    def apply_content_security_policy
      response.headers['Content-Security-Policy'] = build_content_security_policy
    end

    # This method should be overridden with options on a per-controller basis
    # The hash will get merged on top of the DEFAULT_POLICY above
    def content_security_policy_overrides
      {}
    end

    # Builds the value of the Content-Security-Policy header
    def build_content_security_policy
      # build the resulting hash of policies
      content_security_policy_overrides.each_with_object(DEFAULT_POLICY.dup) do |(key, values), policy|
        if policy.key?(key)
          policy.merge!(key => (policy[key] - ["'none'"]).concat(Array(values)))
        else
          policy.merge!(key => Array(values))
        end
      # convert the hash into a string
      end.each_with_object([]) do |(key, values), header|
        header << "#{key} #{values.join(' ')}"
      end.join('; ')
    end
  end
end
