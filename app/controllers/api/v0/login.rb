
class Api::V0::Login < Grape::API
  desc 'User login'
  post '/login' do

    params do
      requires :email,    type: String, desc: 'User Email'
      requires :password, type: String, desc: 'User Password'
    end

    user = User.find_by(email: params[:email])

    if user&.valid_password? params[:password]
      resp = { auth_token: user.auth_token }
    else
      status 400
      resp = { message: "Email or Password invalid!" }
    end

    present resp

  end
end

