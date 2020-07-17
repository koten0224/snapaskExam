module Api::V0::Helpers

  def authenticate!
    current_user || raise(ActiveRecord::RecordNotFound)
  end

  def current_user
    User.find_by(auth_token: params[:auth_token])
  end

end
