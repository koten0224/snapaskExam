module PurchaseItems::Tutorial
  def tutorial(tutorial)
    
    purchased = current_user.purchased_tutorials.find_or_create_by(
      tutorial_id: tutorial.id
    )

    if purchased.errors.any?
      return result_status false, purchased.errors.full_messages
    end

    record = current_user.transaction_records.new(
      purchased_tutorial_id: purchased.id
    )
    if record.save
      purchased.deadline = tutorial.expiration.days.after
      purchased.save
      result_status true, ["Merchandise success!"]
    else
      result_status false, record.errors.full_messages
    end

  end
end