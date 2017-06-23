require 'rails_helper'

class HttpCachingController < ActionController::Base
  include ShiftCommerce::HttpCaching

  def index
    render body: nil
  end
end

class HttpCachingWithSharedPageController < HttpCachingController
  cache_shared_page

  def index
    ::FlexCommerce::StaticPage.includes([]).find(1).first
    render body: nil
  end
end

class HttpCachingWithPrivatePageController < HttpCachingController
  cache_private_page

  def index
    ::FlexCommerce::StaticPage.includes([]).find(1).first
    render body: nil
  end
end

describe ShiftCommerce::HttpCaching, type: :controller do

  after do
    Rails.application.reload_routes!
  end

  context 'without invoking a HttpCaching method' do
    before do
      @controller = HttpCachingController.new

      Rails.application.routes.draw do
        get '/http_caching' => 'http_caching#index'
      end
    end

    it "should set a private Cache-Control header" do
      get :index

      expect(response.header['Cache-Control']).to include('private, max-age=0, must-revalidate')
    end
  end

  context 'when cache_shared_page is set' do
    before do
      @controller = HttpCachingWithSharedPageController.new

      Rails.application.routes.draw do
        get '/http_caching_shared' => 'http_caching_with_shared_page#index'
      end

      ENV['FASTLY_ENABLE_ESI'] = 'true'
    end

    it "should apply surrogate keys correctly" do
      stub_request(:get, /.*\/testaccount\/v1\/static_pages\/1\.json_api/).
        to_return(status: 200, body: '', headers: {
          'External-Surrogate-Key': 'foo bar'
        })

      get :index

      expect(response.header['Cache-Control']).to eq('max-age=0, must-revalidate')
      expect(response.header['Surrogate-Key']).to eq('foo bar')
      expect(response.header['Surrogate-Control']).to include('max-age=3600,stale-if-error=86400,stale-while-revalidate=86400')
    end
  end

  context 'when cache_private_page is set' do
    before do
      @controller = HttpCachingWithPrivatePageController.new

      Rails.application.routes.draw do
        get '/http_caching_private' => 'http_caching_with_private_page#index'
      end

      ENV['FASTLY_ENABLE_ESI'] = 'true'
    end

    it "should apply surrogate keys correctly" do
      stub_request(:get, /.*\/testaccount\/v1\/static_pages\/1\.json_api/).
        to_return(status: 200, body: '', headers: {
          'External-Surrogate-Key': 'foo bar'
        })

      get :index

      expect(response.header['Vary']).to eq('Cookie')
      expect(response.header['Surrogate-Key']).to eq('foo bar')
      expect(response.header['Cache-Control']).to eq('max-age=0, must-revalidate')
      expect(response.header['Surrogate-Control']).to include('max-age=3600,stale-if-error=86400,stale-while-revalidate=86400')
    end
  end

end
