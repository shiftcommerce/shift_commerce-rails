#
# NotFoundRedirects
#
# When a 404 is hit, we lookup possible redirects
#
module ShiftCommerce
  module NotFoundRedirects
    extend ActiveSupport::Concern

    included do
      rescue_from FlexCommerceApi::Error::NotFound, FlexCommerceApi::Error::InternalServer, with: :handle_resource_not_found
    end

    # default handler for API lookup 404 Not Found responses
    def handle_resource_not_found(exception = nil)
      redirect_params = redirect_lookup_params.merge(source_path: request.path)
      # attempt to locate a matching redirect
      redirect = FlexCommerce::Redirect.find_by_resource(redirect_params)
      # if found, build URL and redirect
      if redirect
        redirect_url = destination_for_redirect(redirect)
        redirect_to redirect_url, status: redirect.status_code
      else
        log_exception(exception)
        handle_not_found(exception)
      end
    # when redirects cannot be found, handle using regular 404 process
    rescue ::FlexCommerceApi::Error::NotFound => ex
      log_exception(ex)
      handle_not_found(ex)
    end

    # default behavior for handling not found errors, easily overridable and reusable
    def handle_not_found(exception = nil)
      if exception
        raise(exception)
      else
        raise StandardError, "#{self.class.name}#handle_not_found called without exception, this method should be overridden."
      end
    end

    protected

    # receives a FlexCommerce::Redirect object and returns a path to redirect to
    def destination_for_redirect(redirect)
      case redirect.destination_type
      when "exact".freeze
        redirect.destination_path
      when "products".freeze, "static_pages".freeze, "categories".freeze
        generate_url_for(redirect.destination_slug)
      else
        raise NotImplementedError, "Unknown redirect type '#{redirect.destination_type}'\n  #{redirect.inspect}"
      end
    end

    private

    # to be overridden by resource-based controllers to pass source_type and source_slug
    def redirect_lookup_params
      {}
    end

    def log_exception(ex)
      return unless ex
      # log the exception
      Rails.logger.error(ex)
      # log the exception with Sentry, if available
      Raven.capture_exception(ex) if defined?(Raven)
    end
  end
end
