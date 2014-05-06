require 'spec_helper'

describe EventsController do
  let(:valid_attributes) { { 'started_at' => '2014-05-01 12:21:43' } }
  let(:event) { create(:event) }

  describe 'GET show' do
    it 'assigns the requested event as @event' do
      get :show, { id: event.to_param }
      assigns(:event).should eq(event)
    end
  end

  describe 'GET latest' do
    it 'assigns the requested event as @event' do
      get :latest, { id: event.to_param }
      assigns(:event).should eq(event)
    end
  end

  describe 'PUT calculate' do
    describe 'signed in as user' do
      sign_in_user('user')

      it 'will raise not_found error' do
        expect {
          put :calculate, { id: event.to_param }
        }.to raise_error(ActionController::RoutingError)
      end
    end

    describe 'signed in as judge' do
      sign_in_user('judge')
    end
  end
end
