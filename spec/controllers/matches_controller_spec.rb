require 'spec_helper'

describe MatchesController do
  let(:match) { create(:match) }
  let(:valid_attributes) { attributes_for(:match) }
  let(:date) { Time.current.strftime('%d-%m-%Y') }

  before(:each) do
    create(:season)
  end

  sign_in_user('user')

  describe 'GET new' do
    it 'assigns a new match as @match' do
      get :new
      assigns(:match).should be_a_new(Match)
    end
  end

  describe 'GET edit' do
    describe 'signed in as judge' do
      sign_in_user('judge')

      it 'assigns the requested match as @match' do
        get :edit, { id: match.to_param }
        assigns(:match).should eq(match)
      end
    end

    describe 'signed in as user who created event' do
      sign_in_user('user')

      it 'assigns the requested match as @match' do
        match = create(:match)
        match.update_attribute(:first_player_id, subject.current_user.id)
        get :edit, { id: match.to_param }
        assigns(:match).should eq(match)
      end
    end

    describe 'signed in user who did not create event' do
      sign_in_user('user')

      it 'raises not_found error' do
        expect {
          get :edit, { id: match.to_param }
        }.to raise_error(ActionController::RoutingError)
      end
    end
  end

  describe 'POST create' do
    before(:each) do
      create(:event)
    end

    describe 'with valid params' do
      it 'creates a new Match' do
        expect {
          post :create, { match: valid_attributes }
        }.to change(Match, :count).by(1)
      end

      it 'assigns a newly created match as @match' do
        post :create, { match: valid_attributes }
        assigns(:match).should be_a(Match)
        assigns(:match).should be_persisted
      end

      it 'redirects to the event' do
        post :create, { match: valid_attributes }
        response.should redirect_to(Event.current)
      end
    end

    describe 'with invalid params' do
      it 'assigns a newly created but unsaved match as @match' do
        Match.any_instance.stub(:save).and_return(false)
        post :create, { match: { invalid: '' }}
        assigns(:match).should be_a_new(Match)
      end

      it 're-renders the new template' do
        Match.any_instance.stub(:save).and_return(false)
        post :create, { match: { invalid: '' }}
        response.should render_template('new')
      end
    end
  end

  describe 'PUT update' do
    before(:each) do
      create(:event)
    end

    describe 'signed in as judge' do
      sign_in_user('judge')

      it 'updates the requested match' do
        Match.any_instance.
          should_receive(:update).
          with({ 'played_on' => date })

        put :update, { id: match.to_param, match: { 'played_on' => date }}
      end

      it 'assigns the requested match as @match' do
        put :update, { id: match.to_param, match: valid_attributes}
        assigns(:match).should eq(match)
      end

      it 'redirects to the match event' do
        put :update, { id: match.to_param, match: valid_attributes }
        response.should redirect_to(match.event)
      end
    end

    describe 'signed in as user who created event' do
      sign_in_user('user')

      it 'updates the requested match' do
        match = create(:match)
        match.update_attribute(:first_player_id, subject.current_user.id)

        Match.any_instance.
          should_receive(:update).
          with({ 'played_on' => date })

        put :update, { id: match.to_param, match: { 'played_on' => date }}
      end

      it 'assigns the requested match as @match' do
        match = create(:match)
        match.update_attribute(:first_player_id, subject.current_user.id)

        put :update, { id: match.to_param, match: valid_attributes}
        assigns(:match).should eq(match)
      end

      it 'redirects to the event' do
        match = create(:match)
        match.update_attribute(:first_player_id, subject.current_user.id)

        put :update, { id: match.to_param, match: valid_attributes }
        response.should redirect_to(match.event)
      end

      it 'assigns the requested match as @match' do
        match = create(:match)
        match.update_attribute(:first_player_id, subject.current_user.id)

        get :edit, { id: match.to_param }
        assigns(:match).should eq(match)
      end
    end

    describe 'signed in as user who did not create event' do
      sign_in_user('user')

      it 'raises not_found error' do
        expect {
          get :edit, { id: match.to_param }
        }.to raise_error(ActionController::RoutingError)
      end
    end
  end

  describe 'DELETE destroy' do
    before(:each) do
      create(:event)
    end

    describe 'signed in as judge' do
      sign_in_user('judge')

      it 'destroys the requested match' do
        match = create(:match)

        expect {
          delete :destroy, { id: match.to_param }
        }.to change(Match, :count).by(-1)
      end

      it 'redirects to the matches list' do
        match = create(:match)

        delete :destroy, { id: match.to_param }
        response.should redirect_to(matches_url)
      end
    end

    describe 'signed in as user who created event' do
      sign_in_user('user')

      it 'destroys the requested match' do
        match = create(:match)
        match.update_attribute(:first_player_id, subject.current_user.id)

        expect {
          delete :destroy, { id: match.to_param }
        }.to change(Match, :count).by(-1)
      end

      it 'redirects to the matches list' do
        match = create(:match)
        match.update_attribute(:first_player_id, subject.current_user.id)

        delete :destroy, { id: match.to_param }
        response.should redirect_to(matches_url)
      end
    end

    describe 'signed in as user who did not create event' do
      sign_in_user('user')

      it 'raises not_found error' do
        match = create(:match)

        expect {
          delete :destroy, { id: match.to_param }
        }.to raise_error(ActionController::RoutingError)
      end
    end

    describe 'deleting match in event that was already rated' do
      sign_in_user('judge')

      it 'raises not_found error' do
        match = create(:match)
        match.event.update_attribute(:is_rated, true)

        expect {
          delete :destroy, { id: match.to_param }
        }.to raise_error(ActionController::RoutingError)
      end
    end
  end
end
