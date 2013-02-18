class ApplicationController < ActionController::Base
  protect_from_forgery
  layout "fluid"

  private

  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :participant
      new_participant_session_path
    else
      root_path
    end
  end
end
