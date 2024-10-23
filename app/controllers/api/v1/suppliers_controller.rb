class Api::V1::SuppliersController < Api::V1::ApiController
  def index
    suppliers = Supplier.all
    render json: suppliers
  end

  def show
    supplier = Supplier.find(params[:id])
    render json: supplier
  end

  def search
    suppliers = Supplier.where("name LIKE ?", "#{params[:name]}%") unless params[:category_id] || params[:state_id]
    
    suppliers = search_operator if params[:category_id] || params[:state_id]

    render json: suppliers
  end

  private

  def search_operator
    if params[:operator]&.downcase == 'and'
      Supplier.joins(:categories, :states).where("categories.id = ?", params[:category_id])
              .and(Supplier.joins(:categories, :states).where("states.id = ?", params[:state_id]))
              .uniq
    else
      Supplier.joins(:categories, :states).where("categories.id = ?", params[:category_id])
              .or(Supplier.joins(:categories, :states).where("states.id = ?", params[:state_id]))
              .uniq
    end
  end
end
