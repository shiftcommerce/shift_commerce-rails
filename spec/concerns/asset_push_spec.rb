require 'rails_helper'

class AssetPushController < ActionController::Base
  include ShiftCommerce::AssetPush
  
  def index
    render body: nil
  end
end

class AssetPushWithPresentAssetsController < AssetPushController
  private def push_assets
    ['foo.js', 'bar.css']
  end
end

class AssetPushWithEmptyAssetsController < AssetPushController
  private def push_assets
    []
  end
end

describe ShiftCommerce::AssetPush, type: :controller do

  context 'with push_assets defined and present' do
    before do
      @controller = AssetPushWithPresentAssetsController.new

      Rails.application.routes.draw do
        get '/present_assets' => 'asset_push_with_present_assets#index'
      end
    end

    it "should set the Link header with the contents of push_assets" do
      get :index

      expect(response.header['Link']).to include('</foo.js>; rel=preload; as=script')
      expect(response.header['Link']).to include('</bar.css>; rel=preload; as=style')
    end
  end
  
  context 'with push_assets defined but empty' do
    before do
      @controller = AssetPushWithEmptyAssetsController.new

      Rails.application.routes.draw do
        get '/empty_assets' => 'asset_push_with_empty_assets#index'
      end
    end

    it "should not set a Link header" do
      get :index

      expect(response.header).to_not have_key('Link')
    end
  end

  context 'without push_assets defined' do
    before do
      @controller = AssetPushController.new
    end

    it "should raise an error if push_assets is not overriden" do
      expect { controller.send(:push_assets) }.to raise_error(NotImplementedError)
    end
  end

end
