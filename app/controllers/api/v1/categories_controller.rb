class Api::V1::CategoriesController < Api::V1::ApiController
  def index
    category = Category.all
    render status: 200, json: category.as_json(except: %i[created_at updated_at])
  end
end
