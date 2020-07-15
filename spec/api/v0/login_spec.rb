require 'rails_helper'

RSpec.describe "Authenticate", type: :request do

  before(:all) do
    @user = User.find_or_create_by(email: 'test123@gmail.com') do |user|
      user.password = "111111"
      user.password_confirmation = "111111"
    end
  end

  context 'POST /api/v0/login' do
    it 'should return 201 and token' do

      post '/api/v0/login', params: {
        email: "test123@gmail.com" ,
        password: "111111"
      }
      expect(response.status).to eq(201)

      result = JSON.parse(response.body)
      expect(result.include? "auth_token").to eq(true)
      
      token = result["auth_token"]
      expect(token).to eq(@user.auth_token)

    end

    it 'should return error' do
      
      post '/api/v0/login', params: {
        email: "test123@gmail.com" ,
        password: "zzzzzz"
      }
      expect(response.status).to eq(201)

      result = JSON.parse(response.body)
      expect(result.include? "error").to eq(true)

    end
  end
end
