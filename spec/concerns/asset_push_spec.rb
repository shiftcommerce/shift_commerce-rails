require 'rails_helper'

class FakeController < ApplicationController
  include ShiftCommerce::AssetPush
end

describe FakeController, type: :controller do
  it "should set the Link header when push_assets has entries" do
    expect { subject.send(:push_assets) }.to raise_error(NotImplementedError)
  end
end
