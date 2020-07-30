class Api::V0::Tutorial < Grape::API
  desc "Get Tutorials List"
  get "/tutorials" do
    present Tutorial.all, with: Api::V0::Entities::Tutorial
  end

  desc "Get Single Tutorial"
  get "/tutorial/:id" do
    present Tutorial.find(params[:id]), with: Api::V0::Entities::Tutorial
  end
end
