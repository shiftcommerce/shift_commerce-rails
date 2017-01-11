require 'rails_helper'

class ResourceUrlController < ActionController::Base
  include ShiftCommerce::ResourceUrl
end

describe ShiftCommerce::ResourceUrl, type: :controller do

  before do
    @controller = ResourceUrlController.new
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

      expect(controller.send(:generate_absolute_url_for, path, params, 'http://localhost')).to eq('http://localhost/path?foo=bar&baz=bat')
    end
  end

end
