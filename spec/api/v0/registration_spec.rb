require 'rails_helper'

RSpec.describe "Registrations", type: :request do
  context 'POST /api/v0/sign_up' do
    
    it 'should return 200 and token' do
      
      email = Faker::Internet.email
      password = "111111"
      
      post '/api/v0/sign_up', params: {
        email: email, 
        password: password, 
        password_confirmation: password 
      }

      result = JSON.parse(response.body)
      
      expect(response.status).to eq(201)
      expect(result).to include "auth_token"

      token = result["auth_token"]
      user = User.find_by(auth_token: token)
      expect(user.email).to eq(email)
      expect(user).to be_valid_password "111111"

    end

    it 'should ' do
      user = create :user
      password = "111111"
      params_list = [
        {
          email: user.email,
          password: password,
          password_confirmation: password
        },
        {
          email: "",
          password: "333",
          password_confirmation: "333"
        },
        {
          email: "123@query",
          password: "123123",
          password_confirmation: "456456"
        }
      ]

      params_list.each do |params|
        post '/api/v0/sign_up', params: params
        result = JSON.parse(response.body)
        expect(response.status).to eq 400
        expect(result).to include "message"

      end
    end
  end
end
