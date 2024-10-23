class Api::V1::SuppliersController < Api::V1::ApiController
  def index
    suppliers = Supplier.all
    render json: json_suppliers(suppliers)
  end

  def show
    supplier = Supplier.find(params[:id])
    render json: json_supplier(supplier)
  end

  def search
    suppliers = Supplier.where("name LIKE ?", "#{params[:name]}%") unless params[:category_id] || params[:state_id]
    
    suppliers = search_operator if params[:category_id] || params[:state_id]

    render json: json_suppliers(suppliers)
  end

  private

  def json_suppliers(suppliers)
    suppliers.map do |supplier|
      json_supplier(supplier)
    end
  end

  def json_supplier(supplier)
    supplier.serializable_hash(
      except: %i[created_at updated_at],
      include: { 
        categories: { except: %i[created_at updated_at] },
        states: { except: %i[created_at updated_at] }
      }
    )
  end

  def search_operator
    if params[:operator]&.downcase == 'and'
      Supplier.joins(:categories, :states).where("categories.id = ?", params[:category_id])
              .and(Supplier.joins(:categories, :states).where("states.id = ?", params[:state_id]))
    else
      Supplier.joins(:categories, :states).where("categories.id = ?", params[:category_id])
              .or(Supplier.joins(:categories, :states).where("states.id = ?", params[:state_id]))
    end
  end
end
