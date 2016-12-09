require 'rails_helper'

class ResourceUrlController < ApplicationController
  include ShiftCommerce::ResourceUrl

  # override, as we don't have access to the real root_url here
  def root_url
    'http://localhost/'
  end
end

describe ShiftCommerce::ResourceUrl, type: :controller do

  before do
    @controller = ResourceUrlController.new

    Rails.application.routes.draw do
      root to: 'resource_url#index'
    end
  end

  context 'generate_url_for' do
    it "should output a valid relative URL, stripping unwanted parameters" do
      path = '/path'
      params = "foo=bar&action=deleteme&baz=bat"

      expect(controller.send(:generate_url_for, path, params)).to eq('/path?foo=bar&baz=bat')
    end
  end

  context 'generate_absolute_url_for' do
    it "should output a valid absolute URL, stripping unwanted parameters" do
      path = '/path'
      params = "foo=bar&action=deleteme&baz=bat"

      expect(controller.send(:generate_absolute_url_for, path, params)).to eq('http://localhost/path?foo=bar&baz=bat')
    end
  end

end
