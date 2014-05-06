class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def index
  end

  private
    def choke_non_judge
      unless current_user.is_judge
        not_found
      end
    end

  protected
    def not_found
      raise ActionController::RoutingError.new('Not found')
    end
end
