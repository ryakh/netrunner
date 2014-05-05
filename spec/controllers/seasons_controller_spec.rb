require 'spec_helper'

describe SeasonsController do
  let(:valid_attributes) { { 'name' => 'Season 2' } }
  let(:invalid_attributes) { { 'name' => '' } }
  let(:season) { create(:season) }

  describe 'GET index' do
    it 'redirects to the latest season' do
      season = create(:season)
      get :index
      expect(response).to redirect_to(season_path(season.id))
    end
  end

  describe 'GET show' do
    it 'assigns the requested season as @season' do
      get :show, { id: season.to_param }
      assigns(:season).should eq(season)
    end
  end

  describe 'GET new' do
    it 'assigns a new season as @season' do
      get :new
      assigns(:season).should be_a_new(Season)
    end
  end

  describe 'GET edit' do
    it 'assigns the requested season as @season' do
      get :edit, { id: season.to_param }
      assigns(:season).should eq(season)
    end
  end

  describe 'POST create' do
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

  describe 'PUT update' do
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

  describe 'DELETE destroy' do
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
