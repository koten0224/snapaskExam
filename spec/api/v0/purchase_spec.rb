require 'rails_helper'

RSpec.describe "Purchase tutorials", type: :request do

  before(:all) do
    @teacher = create :teacher
    @user = create :user
    10.times do |x|
      create :tutorial, user: @teacher
    end
  end

  context 'buy tutorials' do

    it 'should purchase tutorial' do
      get "/api/v0/purchased_tutorials/#{@user.auth_token}"
      result = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(result.length).to eq(0)

      @teacher.tutorials.sample(5).each_with_index do |tutorial, index|

        post "/api/v0/purchased_tutorials", params: {
          auth_token: @user.auth_token,
          tutorial_id: tutorial.id
        }
        expect(response.status).to eq(201)
        expect(@user.purchased_tutorials.count).to eq(index+1)

        post "/api/v0/purchased_tutorials", params: {
          auth_token: @user.auth_token,
          tutorial_id: tutorial.id
        }
        result = JSON.parse(response.body)
        expect(result.include? "error").to eq(true)

      end

      get "/api/v0/purchased_tutorials/#{@user.auth_token}"
      result = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(result.length).to eq(5)

      purchased_tutorial = @user.purchased_tutorials.sample
      purchased_tutorial.deadline = 1.days.ago
      purchased_tutorial.save

      get "/api/v0/purchased_tutorials/#{@user.auth_token}?available=true"
      result = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(result.length).to eq(4)

      catagory = ::Tutorial.catagories.find{ |key, value| value == 0 }.first
      get "/api/v0/purchased_tutorials/#{@user.auth_token}?catagory=#{catagory}"
      result = JSON.parse(response.body)
      expect(response.status).to eq(200)
      query_result = @user.purchased_tutorials
                          .joins(:tutorial)
                          .where("tutorials.catagory = 0")
      expect(result.length).to eq(query_result.count)

      post "/api/v0/purchased_tutorials", params: {
          auth_token: @user.auth_token,
          tutorial_id: purchased_tutorial.tutorial_id
      }
      expect(response.status).to eq(201)
      expect(@user.transaction_records.count).to eq(6)
      expect(@user.purchased_tutorials.count).to eq(5)

    end

    it 'should not purchase tutorial' do
      tutorial = @teacher.tutorials.sample
      tutorial.available = false
      tutorial.save
      post "/api/v0/purchased_tutorials", params: {
        auth_token: @user.auth_token,
        tutorial_id: tutorial.id
      }
      result = JSON.parse(response.body)
      expect(result.include? "error").to eq (true)
    end

  end
end
