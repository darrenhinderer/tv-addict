class WelcomeController < ApplicationController

  #normal web surfers should be directed to facebook to install the app
  def index
    redirect_to "http://apps.facebook.com/teevee_addict"
  end

end
