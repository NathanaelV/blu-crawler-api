class Api::V1::StatesController < Api::V1::ApiController
  def index
    state = State.all
    render status: 200, json: state.as_json(except: %i[created_at updated_at])
  end
end
