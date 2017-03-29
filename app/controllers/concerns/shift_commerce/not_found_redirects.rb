#
# NotFoundRedirects
#
# When a 404 is hit, we lookup possible redirects
#
module ShiftCommerce
  module NotFoundRedirects
    extend ActiveSupport::Concern

    included do
      rescue_from ::FlexCommerceApi::Error::NotFound, ActionController::RoutingError,
        with: :handle_resource_not_found
    end

    # default handler for API lookup 404 Not Found responses
    def handle_resource_not_found(exception = nil)
      # attempt to locate a matching redirect
      redirect = FlexCommerce::Redirect.find_by_path(source_path: request.path)
      # if found, build URL and redirect
      if redirect
        redirect_url = redirect.destination_path
        redirect_to redirect_url, status: redirect.status_code
      else
        log_exception(exception)
        handle_not_found(exception)
      end
    # when redirects cannot be found, handle using regular 404 process
    rescue ::FlexCommerceApi::Error::NotFound => ex
      log_exception(ex)
      handle_not_found(exception)
    end

    # default behavior for handling not found errors, easily overridable and reusable
    def handle_not_found(exception = nil)
      raise(exception)
    end

    private

    def log_exception(ex)
      return unless ex
      # log the exception
      Rails.logger.error(ex)
      # log the exception with Sentry, if available
      Raven.capture_exception(ex) if defined?(Raven)
    end
  end
end
