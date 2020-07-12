class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    @tutorials = Tutorial.all
  end
end
