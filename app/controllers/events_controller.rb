class EventsController < ApplicationController
  before_action :set_event,          only: [:show, :calculate]
  before_action :authenticate_user!, only: [:calculate]
  before_action :choke_non_judge,    only: [:calculate]

  def show
  end

  def latest
    @event = Event.find_by(is_closed: false)
  end

  def calculate
    @event.calculate
  end

  private
    def set_event
      @event = Event.find(params[:id])
    end
end
