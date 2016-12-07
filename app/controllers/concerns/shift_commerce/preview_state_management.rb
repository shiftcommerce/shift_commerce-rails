#
# PreviewStateManagement concern
#
# This module contains logic for handling the preview state
#
module ShiftCommerce
  module PreviewStateManagement
    extend ActiveSupport::Concern

    included do
      # Check for the previewed state.
      around_action :handle_preview_state
    end

    protected

    def handle_preview_state
      if params[:preview].present?
        begin
          # Doing this is not particular pretty and raises a question to thread
          # safety of the underlying gem implementation. This MUST be addressed
          # later - FIXME
          FlexCommerceApi::ApiBase.reconfigure_all include_previewed: true
          yield
        ensure
          FlexCommerceApi::ApiBase.reconfigure_all
        end
      else
        yield
      end
    end
  end
end
