module V0
  class Tutorial < Grape::API
    desc "Get Tutorials List"
    get "/tutorials" do
      present ::Tutorial.all, with: V0::Entities::Tutorial
    end
    get "/tutorial/:id" do
      present ::Tutorial.find(params[:id]), with: V0::Entities::Tutorial
    end
  end
end