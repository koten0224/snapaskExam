require 'rails_helper'

RSpec.describe "Tutorials", type: :request do

  before :each do
    @teacher = create :teacher
    @categories = 3.times.map{ create :category }
    @tutorials = 10.times.map do
      create :tutorial, user: @teacher, category: @categories.sample
    end
  end

  context 'GET /api/v0/tutorials' do

    it 'should return list length 10.' do
      get "/api/v0/tutorials"
      result = JSON.parse(response.body)
      expect(response.status).to be 200
      expect(result.length).to be 10
    end

    it 'should return single tutorial.' do
      tutorial = @tutorials.sample
      get "/api/v0/tutorial/#{tutorial.id}"
      result = JSON.parse(response.body)
      expect(response.status).to be 200
      expect(result["id"]).to be tutorial.id
    end

  end

end