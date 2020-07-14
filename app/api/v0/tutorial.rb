module V0
  class Tutorial < Grape::API
    desc "Get Tutorials List"
    get "/tutorials" do
      present ::Tutorial.all
    end
    get "/tutorial/:id" do
      present ::Tutorial.find(params[:id])
    end
  end
end