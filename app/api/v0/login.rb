module V0
  class Login < Grape::API
    post '/login' do

      params do
        requires :email,    type: String, desc: 'User Email'
        requires :password, type: String, desc: 'User Password'
      end

      user = ::User.find_by(email: params[:email])

      if user&.valid_password? params[:password]
        resp = { auth_token: user.auth_token }
      else
        resp = { error: "Email or Password invalid!" }
      end

      present resp

    end
  end
end
