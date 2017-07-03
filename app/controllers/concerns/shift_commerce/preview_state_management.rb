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
      around_action :handle_preview_state, if: :preview_mode_enabled?
      # if caching was to be applied, prevent it
      skip_after_action :vary_page_caching_on_user, if: :preview_mode_enabled?, raise: false
      skip_around_action :capture_and_apply_surrogate_keys, if: :preview_mode_enabled?, raise: false
    end


    protected

    def handle_preview_state
      # Doing this is not particular pretty and raises a question to thread
      # safety of the underlying gem implementation. This MUST be addressed
      # later - FIXME
      FlexCommerceApi::ApiBase.reconfigure_all include_previewed: true
      yield
    ensure
      FlexCommerceApi::ApiBase.reconfigure_all
    end

    def preview_mode_enabled?
      params[:preview].present?
    end
  end
end
