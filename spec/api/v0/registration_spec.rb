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
      expect(result.include? "auth_token").to eq(true)

      token = result["auth_token"]

      user = User.find_by(auth_token: token)
      expect(user.email).to eq(email)
      expect(user.valid_password? "111111").to eq(true)

    end

    it 'sould return errors' do

      email = Faker::Internet.email
      password = "111111"

      post '/api/v0/sign_up', params: {
        email: email, 
        password: password, 
        password_confirmation: password 
      }

      params_list = [
        {
          email: email,
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
        
        expect(response.status).to eq(201)
        expect(result.include? "error").to eq(true)

      end
    end
  end
end
