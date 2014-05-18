require 'spec_helper'

describe UsersController do
  let(:user) { create(:user) }

  sign_in_user('user')

  describe 'GET profile' do
    it 'returns http success' do
      get 'profile'
      response.should be_success
    end
  end

  describe 'PUT update' do
    it 'returns http success' do
      put 'update', { user: { fullname: 'name', password: '' }}
      response.should redirect_to(new_user_session_path)
    end
  end
end
