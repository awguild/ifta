class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!
  #let the general public access the index page

  def index
    redirect_to after_sign_in_path_for current_user if current_user
  end

end
