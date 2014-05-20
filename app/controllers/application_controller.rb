class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  def index
    @standings = Season.last.current_standings
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

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) << :fullname
    end
end
