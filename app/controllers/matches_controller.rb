class MatchesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_match, only: [:edit, :update, :destroy]
  before_action :choke_unpermitted_user, only: [:edit, :update, :destroy]
  before_action :choke_if_event_is_rated, only: [:destroy]

  def new
    @match = Match.new
  end

  def edit
  end

  def create
    @match = Match.new(match_params)

    respond_to do |format|
      if @match.save
        format.html { redirect_to @match.event, notice: 'Match was successfully created.' }
        format.json { render action: 'show', status: :created, location: @match }
      else
        format.html { render action: 'new' }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @match.update(match_params)
        format.html { redirect_to @match.event, notice: 'Match was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @match.destroy
    respond_to do |format|
      format.html { redirect_to matches_url }
      format.json { head :no_content }
    end
  end

  private
    def set_match
      @match = Match.find(params[:id])
    end

    def match_params
      params.require(:match).permit(
        :played_on,
        :first_player_id,
        :second_player_id,
        :first_player_corporation_id,
        :first_player_runner_id,
        :second_player_corporation_id,
        :second_player_runner_id,
        :first_player_corporation_points,
        :first_player_runner_points,
        :second_player_corporation_points,
        :second_player_runner_points
      )
    end

    def choke_unpermitted_user
      unless ([current_user.id] - permitted_users).empty?
        not_found
      end
    end

    def choke_if_event_is_rated
      if @match.event.is_rated
        not_found
      end
    end

  protected
    def permitted_users
      [
        @match.first_player_id,
        @match.second_player_id,
        User.judges
      ].flatten
    end
end
