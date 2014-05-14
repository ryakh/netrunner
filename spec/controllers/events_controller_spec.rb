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
    describe 'when season is running' do
      before(:each) do
        create(:season)
      end

      it 'assigns the requested event as @event' do
        get :latest
        assigns(:event).should eq(Event.last)
      end

      it 'redirects user to the last event' do
        get :latest
        response.should redirect_to(Event.last)
      end
    end

    describe 'when there is no season running' do
      it 'responds with 404' do
        expect {
          get :latest
        }.to raise_error(ActionController::RoutingError)
      end
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
