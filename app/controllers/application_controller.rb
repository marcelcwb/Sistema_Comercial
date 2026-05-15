class ApplicationController < ActionController::Base
  layout :layout_by_resource

  before_action :authenticate_user!

  rescue_from CanCan::AccessDenied do
    redirect_to root_path, alert: "Voce nao tem permissao para acessar esta area."
  end

  private

  def after_sign_out_path_for(_resource_or_scope)
    new_user_session_path
  end

  def layout_by_resource
    devise_controller? ? "auth" : "application"
  end
end
