class Backoffice::UsersController < ApplicationController
  layout "backoffice"
  def index
    @users = User.salers_actives
  end
end
