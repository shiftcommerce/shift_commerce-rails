require 'rails_helper'

class AssetPushController < ActionController::Base
  include ShiftCommerce::AssetPush
end

class AssetPushWithAssetsController < AssetPushController
  def index
    render nothing: true
  end

  private

  def push_assets
    ['foo.js', 'bar.css']
  end
end

describe ShiftCommerce::AssetPush, type: :controller do

  context 'with push_assets set' do
    before do
      @controller = AssetPushWithAssetsController.new

      Rails.application.routes.draw do
        get '/assets' => 'asset_push_with_assets#index'
      end
    end

    it "should set the Link header with the contents of push_assets" do
      get :index

      expect(response.header['Link']).to include('</foo.js>; rel=preload; as=script')
      expect(response.header['Link']).to include('</bar.css>; rel=preload; as=stylesheet')
    end
  end

  context 'without push_assets set' do
    before do
      @controller = AssetPushController.new
    end

    it "should raise an error if push_assets is not overriden" do
      expect { controller.send(:push_assets) }.to raise_error(NotImplementedError)
    end
  end

end
