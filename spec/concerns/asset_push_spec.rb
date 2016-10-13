require 'rails_helper'

class FakeController < ApplicationController
  include ShiftCommerce::AssetPush
end

class FakeWithAssetsController < FakeController
  def index
    render nothing: true
  end

  private

  def push_assets
    ['foo', 'bar']
  end
end

describe ShiftCommerce::AssetPush, type: :controller do

  context 'with push_assets set' do
    before do
      @controller = FakeWithAssetsController.new

      Rails.application.routes.draw do
        get '/assets' => 'fake_with_assets#index'
      end
    end

    it "should set the Link header with the contents of push_assets" do
      get :index

      expect(response.header['Link']).to include('</foo>; rel=preload')
      expect(response.header['Link']).to include('</bar>; rel=preload')
    end
  end

  context 'without push_assets set' do
    before do
      @controller = FakeController.new
    end

    it "should raise an error if push_assets is not overriden" do
      expect { controller.send(:push_assets) }.to raise_error(NotImplementedError)
    end
  end

end
