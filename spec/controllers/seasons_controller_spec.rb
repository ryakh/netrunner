require 'spec_helper'

describe SeasonsController do
  let(:valid_attributes) { { 'name' => 'Season 2' } }
  let(:invalid_attributes) { { 'name' => '' } }

  let(:season) { create(:season) }

  describe 'GET current_standings' do
    it 'returns success' do
      create(:season)
      event = create(:event)
      create(:match)
      event.update_attribute(:is_closed, true)
      event.calculate
      get :current_standings
      expect(response).to be_success
    end
  end

  describe 'GET index' do
    describe 'with no seasons at all' do
      it 'will raise not_found error' do
        expect {
          get :index
        }.to raise_error(ActionController::RoutingError)
      end
    end

    describe 'with at least one season running' do
      it 'redirects to the latest season' do
        season = create(:season)
        get :index
        expect(response).to redirect_to(season_path(season.id))
      end
    end
  end

  describe 'GET show' do
    it 'assigns the requested season as @season' do
      get :show, { id: season.to_param }
      assigns(:season).should eq(season)
    end
  end


  describe 'GET new' do
    describe 'signed in as user' do
      sign_in_user('user')

      it 'will raise not_found error' do
        expect {
          get :new
        }.to raise_error(ActionController::RoutingError)
      end
    end

    describe 'signed in as judge' do
      sign_in_user('judge')

      it 'assigns a new season as @season' do
        get :new
        assigns(:season).should be_a_new(Season)
      end
    end
  end

  describe 'GET edit' do
    describe 'signed in as user' do
      sign_in_user('user')

      it 'will raise not_found error' do
        expect {
          get :edit, { id: season.to_param }
        }.to raise_error(ActionController::RoutingError)
      end
    end

    describe 'signed in as judge' do
      sign_in_user('judge')

      it 'assigns the requested season as @season' do
        get :edit, { id: season.to_param }
        assigns(:season).should eq(season)
      end
    end

  end

  describe 'POST create' do
    describe 'signed in as user' do
      sign_in_user('user')

      it 'will raise not_found error' do
        expect {
          post :create, { season: valid_attributes }
        }.to raise_error(ActionController::RoutingError)
      end
    end

    describe 'signed in as judge' do
      sign_in_user('judge')

      describe 'with valid params' do
        it 'creates a new Season' do
          expect {
            post :create, { season: valid_attributes }
          }.to change(Season, :count).by(1)
        end

        it 'assigns a newly created season as @season' do
          post :create, { season: valid_attributes }
          assigns(:season).should be_a(Season)
          assigns(:season).should be_persisted
        end

        it 'redirects to the created season' do
          post :create, { season: valid_attributes }
          response.should redirect_to(Season.last)
        end
      end

      describe 'with invalid params' do
        it 'assigns a newly created but unsaved season as @season' do
          post :create, { season: invalid_attributes }
          assigns(:season).should be_a_new(Season)
        end

        it 're-renders the new template' do
          post :create, { season: invalid_attributes }
          response.should render_template('new')
        end
      end
    end
  end

  describe 'PUT update' do
    describe 'signed in as user' do
      sign_in_user('user')

      it 'will raise not_found error' do
        expect {
          put :update, { id: season.to_param, season: valid_attributes }
        }.to raise_error(ActionController::RoutingError)
      end
    end

    describe 'signed in as judge' do
      sign_in_user('judge')

      describe 'with valid params' do
        it 'updates the requested season' do
          Season.any_instance.should_receive(:update).with(valid_attributes)
          put :update, { id: season.to_param, season: valid_attributes }
        end

        it 'assigns the requested season as @season' do
          put :update, { id: season.to_param, season: valid_attributes }
          assigns(:season).should eq(season)
        end

        it 'redirects to the season' do
          put :update, { id: season.to_param, season: valid_attributes }
          response.should redirect_to(season)
        end
      end

      describe 'with invalid params' do
        it 'assigns the season as @season' do
          put :update, { id: season.to_param, season: invalid_attributes }
          assigns(:season).should eq(season)
        end

        it 're-renders the edit template' do
          put :update, { id: season.to_param, season: invalid_attributes }
          response.should render_template('edit')
        end
      end
    end
  end

  describe 'DELETE destroy' do
    describe 'signed in as user' do
      sign_in_user('user')

      it 'will raise not_found error' do
        expect {
          delete :destroy, { id: season.to_param }
        }.to raise_error(ActionController::RoutingError)
      end
    end

    describe 'signed in as judge' do
      sign_in_user('judge')

      it 'destroys the requested season' do
        season = create(:season)

        expect {
          delete :destroy, { id: season.to_param }
        }.to change(Season, :count).by(-1)
      end

      it 'redirects to the seasons list' do
        season = create(:season)

        delete :destroy, { id: season.to_param }
        response.should redirect_to(seasons_url)
      end
    end
  end
end
