require 'spec_helper'

describe MatchesController do
  let(:match) { create(:match) }
  let(:valid_attributes) { attributes_for(:match) }

  describe "GET new" do
    it "assigns a new match as @match" do
      get :new
      assigns(:match).should be_a_new(Match)
    end
  end

  describe "GET edit" do
    it "assigns the requested match as @match" do
      get :edit, { id: match.to_param }
      assigns(:match).should eq(match)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Match" do
        expect {
          post :create, { match: valid_attributes }
        }.to change(Match, :count).by(1)
      end

      it "assigns a newly created match as @match" do
        post :create, { match: valid_attributes }
        assigns(:match).should be_a(Match)
        assigns(:match).should be_persisted
      end

      it "redirects to the event" do
        post :create, { match: valid_attributes }
        response.should redirect_to(Event.current)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved match as @match" do
        Match.any_instance.stub(:save).and_return(false)
        post :create, { match: { invalid: '' }}
        assigns(:match).should be_a_new(Match)
      end

      it "re-renders the 'new' template" do
        Match.any_instance.stub(:save).and_return(false)
        post :create, { match: { invalid: '' }}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested match" do
        Match.any_instance.
          should_receive(:update).
          with({ "played_on" => "2014-05-02" })

        put :update, { id: match.to_param, match: { "played_on" => "2014-05-02" }}
      end

      it "assigns the requested match as @match" do
        put :update, { id: match.to_param, match: valid_attributes}
        assigns(:match).should eq(match)
      end

      it "redirects to the match" do
        put :update, { id: match.to_param, match: valid_attributes }
        response.should redirect_to(match)
      end
    end

    describe "with invalid params" do
      it "assigns the match as @match" do
        Match.any_instance.stub(:save).and_return(false)
        put :update, { id: match.to_param, match: { invlid: '' }}
        assigns(:match).should eq(match)
      end

      it "re-renders the 'edit' template" do
        Match.any_instance.stub(:save).and_return(false)
        put :update, { id: match.to_param, match: { invlid: '' }}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested match" do
      match = create(:match)
      expect {
        delete :destroy, { id: match.to_param }
      }.to change(Match, :count).by(-1)
    end

    it "redirects to the matches list" do
      match = create(:match)
      delete :destroy, { id: match.to_param }
      response.should redirect_to(matches_url)
    end
  end
end
