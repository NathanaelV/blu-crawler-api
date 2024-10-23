class Api::V1::CategoriesController < Api::V1::ApiController
  def index
    categories = Category.all
    render status: 200, json: category_json(categories)
  end

  private 

  def category_json(categories)
    categories.map do |category|
      category.serializable_hash(except: %i[created_at updated_at])
    end
  end
end
