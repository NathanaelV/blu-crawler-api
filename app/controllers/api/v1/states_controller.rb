class Api::V1::StatesController < Api::V1::ApiController
  def index
    states = State.all
    render status: 200, json: state_json(states)
  end

  private 

  def state_json(states)
    states.map do |state|
      state.serializable_hash(except: %i[created_at updated_at])
    end
  end
end
