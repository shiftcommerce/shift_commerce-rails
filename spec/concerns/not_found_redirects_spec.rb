require 'rails_helper'

require 'mocks/redirect_mocks'

class NotFoundRedirectsController < ApplicationController
  include ShiftCommerce::NotFoundRedirects
  include ShiftCommerce::ResourceUrl

  def index
    FlexCommerce::StaticPage.includes([]).find(1).first
  end

  private

  # Overrides NotFoundRedirects#handle_not_found
  # Avoid the test being stopped prematureiy by an expected exception.
  def handle_not_found(exception = nil)
    false
  end
end

describe ShiftCommerce::NotFoundRedirects, type: :controller do

  before do
    stub_request(:get, /.*\/testaccount\/v1\/static_pages\/1\.json_api/).
      to_return(status: 404, body: '', headers: { 'Content-Type': 'application/vnd.api+json' })

    @controller = NotFoundRedirectsController.new

    Rails.application.routes.draw do
      get '/' => 'not_found_redirects#index'
    end
  end

  context 'when accessing a nonexistent resource' do
    context 'with a valid exact path redirect' do
      before do
        stub_request(:get, /.*\/testaccount\/v1\/redirects\.json_api/).
          to_return(status: 200, body: Mocks::Redirects::EXACT_REDIRECT, headers: { 'Content-Type': 'application/vnd.api+json' })
      end

      it "should redirect to the correct path" do
        get :index

        expect(response).to redirect_to '/somewhere_else'
      end

      it "should redirect with the status given in the response" do
        get :index

        expect(response.status).to eq(301)
      end
    end

    context 'with a valid resource redirect' do
      before do
        stub_request(:get, /.*\/testaccount\/v1\/redirects\.json_api/).
          to_return(status: 200, body: Mocks::Redirects::RESOURCE_REDIRECT, headers: { 'Content-Type': 'application/vnd.api+json' })
      end

      it "should redirect the correct path" do
        get :index

        expect(response).to redirect_to '/products/1'
      end

      it "should redirect with the status given in the response" do
        get :index

        expect(response.status).to eq(301)
      end
    end


    context 'with no redirect' do
      before do
        stub_request(:get, /.*\/testaccount\/v1\/redirects\.json_api/).
        to_return(status: 200, body: Mocks::Redirects::EMPTY_REDIRECT, headers: { 'Content-Type': 'application/vnd.api+json' })
      end

      it "should raise an exception" do
        expect { controller.send(:index) }.to raise_error(FlexCommerceApi::Error::NotFound)
      end
    end
  end

end
