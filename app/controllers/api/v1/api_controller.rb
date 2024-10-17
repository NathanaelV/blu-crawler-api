class Api::V1::ApiController < ActionController::API
  rescue_from ActiveRecord::ActiveRecordError, with: :return500
  rescue_from ActiveRecord::RecordNotFound, with: :return404

  private

  def return500
    render status: 500, json: { message: '500 - Problema do lado do servidor' }
  end

  def return404
    render status: 404, json: { message: '404 - Elemento não encontrado' }
  end
end
