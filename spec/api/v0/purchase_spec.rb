require 'rails_helper'

RSpec.describe "Purchase tutorial", type: :request do

  def result
    JSON.parse(response.body)
  end

  def post_to_buy_tutorial
    post "/api/v0/purchased_tutorials", params: {
      auth_token: @user.auth_token,
      tutorial_id: @tutorial.id
    }
  end

  before(:each) do
    @teacher = create :teacher
    @user = create :user
    @categories = 3.times.map{ create :category }
    @tutorials = 10.times.map do |x|
      create :tutorial, user: @teacher, category: @categories.sample
    end
  end

  context 'GET /api/v0/purchased_tutorials/:auth_token' do

    before(:each) do
      @tutorials.each do |tutorial|
        @user.buy.tutorial(tutorial)
      end
    end

    it 'should raise error.' do
      expect do
        get "/api/v0/purchased_tutorials"
      end.to raise_error ActiveRecord::RecordNotFound
    end

    it 'should return list length 10.' do
      get "/api/v0/purchased_tutorials/#{@user.auth_token}"
      expect(response.status).to eq(200)
      expect(result.length).to eq(10)
    end

    it 'should return list match that category.' do
      category = @categories.sample
      get "/api/v0/purchased_tutorials/#{@user.auth_token}?category=#{category.id}"
      expect(response.status).to eq(200)
      expect(result.length).to eq(category.tutorials.count)
    end

    it 'should return available list length 7.' do
      @user.purchased_tutorials.sample(3).each do |purchased|
        purchased.update(deadline: 1.days.ago)
      end
      get "/api/v0/purchased_tutorials/#{@user.auth_token}?available=true"
      expect(response.status).to eq(200)
      expect(result.length).to eq(7)
    end

    it 'should match category and available.' do
      category = @categories.sample
      purchased_tutorials = @user.purchased_tutorials.category(category.id)
      purchased_tutorials.sample.update(deadline: 1.days.ago)
      get "/api/v0/purchased_tutorials/#{@user.auth_token}?category=#{category.id}&available=true"
      expect(response.status).to eq(200)
      expect(result.length).to eq(purchased_tutorials.length - 1)
    end
  end

  context 'POST /api/v0/purchased_tutorials' do

    before(:each) do
      @tutorial = @tutorials.sample
    end

    it 'should raise error.' do
      expect do
        post "/api/v0/purchased_tutorials", params: {
          tutorial_id: @tutorials.sample.id
        }
      end.to raise_error ActiveRecord::RecordNotFound
    end

    it 'should be success.' do
      post_to_buy_tutorial
      expect(response.status).to eq 201
      expect(result).to include "message"
    end

    it 'should not buy twice.' do
      2.times { post_to_buy_tutorial }
      expect(response.status).to eq 400
      expect(result).to include "message"
    end

    it 'should not buy if tutorial is not available.' do
      @tutorial.update(available: false)
      post_to_buy_tutorial
      expect(response.status).to eq 400
      expect(result).to include "message"
    end

    it 'should be success if user purchased is expired.' do
      @user.buy.tutorial(@tutorial)
      purchased = @user.purchased_tutorials.find_by(tutorial_id: @tutorial.id)
      purchased.update(deadline: 1.days.ago)
      post_to_buy_tutorial
      expect(response.status).to eq 201
      expect(result).to include "message"
      expect(@user.transaction_records.count).to eq(2)
      expect(@user.purchased_tutorials.count).to eq(1)
    end

    it 'should not buy when tutorial is not available even though user purchased is expired.' do
      @user.buy.tutorial(@tutorial)
      purchased = @user.purchased_tutorials.find_by(tutorial_id: @tutorial.id)
      purchased.update(deadline: 1.days.ago)
      @tutorial.update(available: false)
      post_to_buy_tutorial
      expect(response.status).to eq 400
      expect(result).to include "message"
      expect(@user.transaction_records.count).to eq(1)
      expect(@user.purchased_tutorials.count).to eq(1)
    end
  end
end
