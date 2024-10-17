class Api::V1::ApiController < ActionController::API
  rescue_from ActiveRecord::ActiveRecordError, with: :return500

  private

  def return500
    render status: 500
  end
end
