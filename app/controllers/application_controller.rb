class ApplicationController < ActionController::Base
    layout :backoffice_login_devise

  private

  def backoffice_login_devise
    if devise_controller? && resource_name == :admin
      "backoffice_login_devise"
    else
      "application"
    end
  end
end
