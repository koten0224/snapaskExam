require 'rails_helper'

RSpec.describe "Authenticate", type: :request do

  before(:all) do
    @user = create :user
  end

  context 'POST /api/v0/login' do
    it 'should return 201 and token' do

      post '/api/v0/login', params: {
        email: @user.email,
        password: "111111"
      }
      expect(response.status).to eq(201)

      result = JSON.parse(response.body)
      expect(result).to include "auth_token"
      
      token = result["auth_token"]
      expect(token).to eq(@user.auth_token)

    end

    it 'should return error' do
      
      post '/api/v0/login', params: {
        email: @user.email,
        password: "zzzzzz"
      }
      result = JSON.parse(response.body)
      expect(response.status).to eq 400
      expect(result).to include "message"

    end
  end
end
