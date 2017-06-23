require 'rails_helper'

require 'mocks/preview_state_management_mocks'

class PreviewStateManagementController < ActionController::Base
  include ShiftCommerce::PreviewStateManagement

  def index
    page = FlexCommerce::StaticPage.includes([]).find(1).first
    render html: page.body_content
  end
end

describe ShiftCommerce::PreviewStateManagement, type: :controller do
  before do
    stub_request(:get, /.*\/testaccount\/v1\/static_pages\/1\.json_api/).
      to_return(status: 200, body: Mocks::PreviewStateManagement::STANDARD_RESPONSE, headers: { 'Content-Type': 'application/vnd.api+json' })
    stub_request(:get, /.*\/testaccount\/v1\/static_pages\/1\.json_api\?preview=true/).
      to_return(status: 200, body: Mocks::PreviewStateManagement::PREVIEW_RESPONSE, headers: { 'Content-Type': 'application/vnd.api+json' })

    @controller = PreviewStateManagementController.new

    Rails.application.routes.draw do
      get '/preview_state_management' => 'preview_state_management#index'
    end
  end

  after do
    Rails.application.reload_routes!
  end

  context 'with the preview disabled' do
    it "should return the published content" do
      get :index

      expect(response.body).to include('Published')
    end
  end

  context 'with the preview enabled' do
    it "should return the scheduled content" do
      get :index, params: { preview: true }

      expect(response.body).to include('Preview')
    end
  end

end
