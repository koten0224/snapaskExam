module V0
  module Helpers

    def authenticate!
      current_user || raise(ActiveRecord::RecordNotFound)
    end

    def current_user
      ::User.find_by(auth_token: params[:auth_token])
    end

  end
end