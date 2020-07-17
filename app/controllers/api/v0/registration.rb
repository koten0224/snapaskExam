
class Api::V0::Registration < Grape::API
  desc "User Registration"
  post "/sign_up" do

    params do
      requires :email,                 type: String, desc: "User Email"
      requires :password,              type: String, desc: "User Password"
      requires :password_confirmation, type: String, desc: "Password Confirmation"
    end

    user = User.new(params)
    
    if user.save
      resp =  { auth_token: user.auth_token }
    else
      resp = { error: user.errors.full_messages }
    end

    present resp

  end
end