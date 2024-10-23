class Api::V1::StatesController < Api::V1::ApiController
  def index
    states = State.all
    render status: 200, json: states
  end
end
