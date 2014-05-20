require 'spec_helper'

describe ApplicationController do
  describe 'GET index' do
    it 'returns success' do
      create(:season)
      create(:event)
      get :index
      expect(response).to be_success
    end
  end
end
