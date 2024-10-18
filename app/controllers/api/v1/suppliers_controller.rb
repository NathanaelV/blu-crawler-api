class Api::V1::SuppliersController < Api::V1::ApiController
  def index
    suppliers = Supplier.all
    render status: 200, json: json_supplier(suppliers)
  end

  def show
    supplier = Supplier.find(params[:id])
    render status: 200, json: json_supplier(supplier)
  end

  def search
    suppliers = Supplier.where("name LIKE ?", "#{params[:name]}%") unless params[:category_id] || params[:state_id]
    
    suppliers = search_operator if params[:category_id] || params[:state_id]

    render status: 200, json: json_supplier(suppliers)
  end

  private

  def json_supplier(supplier)
    supplier.as_json(
      except: %i[created_at updated_at category_id],
      include: { 
        category: { except: %i[created_at updated_at] },
        states: { except: %i[created_at updated_at] }
      }
    )
  end

  def search_operator
    if params[:operator]&.downcase == 'and'
      Supplier.joins(:states).where("suppliers.category_id = ?", params[:category_id])
              .and(Supplier.joins(:states).where("states.id = ?", params[:state_id]))
    else
      Supplier.joins(:states).where("suppliers.category_id = ?", params[:category_id])
              .or(Supplier.joins(:states).where("states.id = ?", params[:state_id]))
    end
  end
end
