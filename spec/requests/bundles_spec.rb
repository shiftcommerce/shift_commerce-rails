require 'rails_helper'
include ShiftCommerce::Engine.routes.url_helpers

require 'mocks/bundle_mocks'

RSpec.describe ShiftCommerce::BundlesController, type: :request do

  context 'Bundles' do
    setup do
      stub_request(:get, /.*\/testaccount\/v1\/bundles\/1\.json_api/).
        to_return(status: 200, body: Mocks::Bundles::BUNDLE, headers: { 'Content-Type': 'application/vnd.api+json' })
      stub_request(:get, /.*\/testaccount\/v1\/bundles\/1\/template_definition\.json_api/).
        to_return(status: 200, body: Mocks::Bundles::BUNDLE, headers: { 'Content-Type': 'application/vnd.api+json' })
    end

    it 'should display their title and body content correctly' do
      get bundles_path(1)

      expect(response.body).to include "Bundle" # title
    end
  end

end
