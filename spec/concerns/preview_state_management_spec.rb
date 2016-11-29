require 'rails_helper'

class PreviewStateManagementController < ApplicationController
  include ShiftCommerce::PreviewStateManagement

  def index
    page = FlexCommerce::StaticPage.includes([]).find(1).first
    render html: page.body_content
  end
end

describe ShiftCommerce::PreviewStateManagement, type: :controller do
  STANDARD_RESPONSE = {
    data: {
      id: "1",
      type: "static_pages",
      links: {
        self: "/testaccount/v1/static_pages/1.json_api"
      },
      attributes: {
        body_content: "Published",
        published: true
      }
    },
    links: {
      self: "/testaccount/v1/static_pages/1.json_api"
    }
  }.to_json

  PREVIEW_RESPONSE = {
    data: {
      id: "1",
      type: "static_pages",
      links: {
        self: "/testaccount/v1/static_pages/1.json_api"
      },
      attributes: {
        body_content: "Preview",
        published: true
      }
    },
    links: {
      self: "/testaccount/v1/static_pages/1.json_api?preview=true"
    }
  }.to_json

  before do
    stub_request(:get, /.*\/testaccount\/v1\/static_pages\/1\.json_api/).
      to_return(status: 200, body: STANDARD_RESPONSE, headers: { 'Content-Type': 'application/vnd.api+json' })
    stub_request(:get, /.*\/testaccount\/v1\/static_pages\/1\.json_api\?preview=true/).
      to_return(status: 200, body: PREVIEW_RESPONSE)

    @controller = PreviewStateManagementController.new

    Rails.application.routes.draw do
      get '/' => 'preview_state_management#index'
    end
  end

  context 'with the preview disabled' do
    it "should return the published content" do
      get :index

      expect(response.body).to include('Published')
    end
  end

  context 'with the preview enabled' do
    it "should return the scheduled content" do
      get :index

      false
    end
  end

end
