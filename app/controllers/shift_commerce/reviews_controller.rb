# frozen_string_literal: true
module ShiftCommerce
  class ReviewsController < ApplicationController
    BAZAARVOICE_SHARED_SECRET = ENV.fetch('BAZAARVOICE_SHARED_SECRET', false).freeze

    skip_before_action :verify_authenticity_token, only: [:generate_bazaarvoice_javascript]
    skip_around_action :capture_surrogate_keys, only: [:generate_bazaarvoice_javascript], raise: false
    before_action :authenticate_account!, only: [:new]

    def new
    end

    def generate_bazaarvoice_javascript
      unless BAZAARVOICE_SHARED_SECRET.present? && current_account && current_account.id
        return head :ok, content_type: 'text/javascript'
      end

      timestamp = Time.now.strftime('%Y%m%d')
      user_string = "date=#{timestamp}&maxage=2&userid=#{current_account.id}"

      @user_token = Digest::MD5.hexdigest(BAZAARVOICE_SHARED_SECRET + user_string) + user_string.unpack("H*").first

      response.headers['Cache-Control'] = 'private, max-age=3600'

      respond_to { |format| format.js }
    end
  end
end

