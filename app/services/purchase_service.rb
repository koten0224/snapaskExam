class PurchaseService
  
  def initialize(user)
    @user = user
  end

  def current_user
    @user
  end

  def result_status(success_status, messages)
    OpenStruct.new(
      success: success_status,
      message: messages
    )
  end

  include PurchaseItems::Tutorial
end