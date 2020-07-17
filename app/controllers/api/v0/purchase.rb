class Api::V0::Purchase < Grape::API
  before { authenticate! }

  desc "Get All Purchased Tutorial For User"
  get "/purchased_tutorials/:auth_token" do
    params do
      requires :auth_token, type: String, desc: "User authenticity token"
      optional :category_id, type: Integer, desc: "Filted by category_id"
      optional :available, type: String, desc: "Give true or false"
    end

    result = current_user.purchased_tutorials
                          .joins(:tutorial)
                          .includes(:tutorial)
                          .includes(:transaction_records)
                          .includes(:category)

    if params.include? "category_id"
      category_id = params["category_id"]
      result = result.where("tutorials.category_id = ?", category_id)
    end

    if params["available"] == "true"
      result = result.where("purchased_tutorials.deadline > ?", Time.now)
    end

    present result, with: Api::V0::Entities::Purchase
  end

  desc "Buy Tutorial"
  post "/purchased_tutorials" do
    params do
      requires :auth_token, type: String, desc: "User authenticity token"
      requires :tutorial_id, type: Integer, desc: "The tutorial that user want to buy"
    end
    tutorial = Tutorial.find(params[:tutorial_id])
    if tutorial.available?
      purchased = current_user.purchased_tutorials.find_or_create_by(tutorial_id: params[:tutorial_id])
      if purchased.deadline && purchased.deadline > Time.now
        resp = { error: "Your Tutorial is still available, not allow to purchase again." }
        present resp
      else
        purchased.deadline = Time.now + tutorial.expiration.days
        purchased.save
        current_user.transaction_records.create(
          purchased_tutorial_id: purchased.id,
          price: tutorial.price,
          currency: tutorial.currency,
          expiration: tutorial.expiration
        )

        present purchased, with: Api::V0::Entities::Purchase
      end
    else
      resp = { error: "This tutorial is not available." }
      present resp
    end
  end
end

