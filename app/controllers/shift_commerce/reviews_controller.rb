# frozen_string_literal: true
module ShiftCommerce
  class ReviewsController < ApplicationController
    before_action :authenticate_account!, only: [:new]

    def new
    end
  end
end

