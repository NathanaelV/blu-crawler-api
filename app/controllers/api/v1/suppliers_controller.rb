class Api::V1::SuppliersController < Api::V1::ApiController
  def index
    supplier = Supplier.all
    render status: 200, json: json_supplier(supplier)
  end

  def show
    supplier = Supplier.find(params[:id])
    render status: 200, json: json_supplier(supplier)
  end

  private

  def json_supplier(supplier)
    supplier.as_json(
      except: %i[created_at updated_at],
      include: { 
        category: { except: %i[created_at updated_at] },
        states: { except: %i[created_at updated_at] }
      }
    )
  end
end
