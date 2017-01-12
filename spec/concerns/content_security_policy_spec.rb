require 'rails_helper'

class CSPTestController < ActionController::Base
  include ShiftCommerce::ContentSecurityPolicy

  def index
    render nothing: true
  end
end


describe ShiftCommerce::ContentSecurityPolicy, type: :controller do
  let(:headers)    { response.headers }
  let(:csp_header) { headers['Content-Security-Policy'] }

  before do
    @controller = CSPTestController.new
    Rails.application.routes.draw { get '/csp' => 'csp_test#index' }
    get :index
  end

  context 'with the CSP' do
    it "should include the Content-Security-Policy Response Header" do
      expect(headers).to have_key('Content-Security-Policy')
    end

    it "should have the correct Content Security Policy" do
      expect(csp_header).to include("default-src 'self';")
      expect(csp_header).to include("base-uri 'self';")
      expect(csp_header).to include("object-src 'none';")
      expect(csp_header).to include("img-src 'self' data:;")
      expect(csp_header).to include("script-src 'self';")
      expect(csp_header).to include("style-src 'self';")
      expect(csp_header).to include("font-src 'self';")
      expect(csp_header).to include("child-src 'none';")
      expect(csp_header).to include("frame-ancestors 'none';")
      expect(csp_header).to include("connect-src 'self'")
    end
  end
end
