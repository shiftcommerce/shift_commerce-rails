require 'rails_helper'
include ShiftCommerce::Engine.routes.url_helpers

require 'mocks/static_page_mocks'

RSpec.describe ShiftCommerce::StaticPagesController, type: :request do

  context 'Static pages' do
    setup do
      stub_request(:get, /.*\/testaccount\/v1\/static_pages\/1\.json_api/).
        to_return(status: 200, body: Mocks::StaticPages::STATIC_PAGE, headers: { 'Content-Type': 'application/vnd.api+json' })
    end

    it 'should display their title and body content correctly' do
      get pages_path(1)

      expect(response.body).to include "Static Page" # title
      expect(response.body).to include "Test" # content
    end
  end

end
