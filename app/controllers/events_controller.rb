class EventsController < ApplicationController
  before_action :set_event,          only: [:show, :calculate]
  before_action :authenticate_user!, only: [:calculate]
  before_action :choke_non_judge,    only: [:calculate]

  def show
  end

  def latest
    get_or_create_event
    redirect_to @event
  end

  def calculate
    @event.calculate
  end

  private
    def set_event
      @event = Event.find(params[:id])
    end

    def get_or_create_event
      event = Event.find_by(
        started_at: Time.now.beginning_of_week,
        finished_at: Time.now.end_of_week
      )

      if event.nil?
        @event = Event.create_current
      else
        @event = event
      end
    end
end
