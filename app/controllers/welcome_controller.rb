class WelcomeController < ApplicationController
  skip_before_filter :authenticate_user!
  skip_before_filter :check_contact_info
  #let the general public access the index page
  
  def index
  end
end
