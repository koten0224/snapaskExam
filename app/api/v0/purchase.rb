module V0
  class Purchase < Grape::API
    before { authenticate! }

    desc "Get All Purchased Tutorial For User"
    get "/purchased_tutorials/:auth_token" do
      params do
        requires :auth_token, type: String, desc: "User authenticity token"
      end
      present current_user.purchased_tutorials, with: V0::Entities::Purchase
    end

    desc "Buy Tutorial"
    post "/purchased_tutorials" do
      params do
        requires :auth_token, type: String, desc: "User authenticity token"
        requires :tutorial_id, type: Integer, desc: "The tutorial that user want to buy"
      end
      tutorial = ::Tutorial.find(params[:tutorial_id])
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
          price_type: tutorial.price_type,
          expiration: tutorial.expiration
        )

        present purchased, with: V0::Entities::Purchase
      end
    end
  end
end
