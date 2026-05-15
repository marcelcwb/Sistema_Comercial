class StockMovementsController < ApplicationController
  before_action :set_product
  before_action :authorize_stock_movement

  def new
    @stock_movement = @product.stock_movements.new
  end

  def create
    @stock_movement = @product.stock_movements.new(stock_movement_params)

    if @stock_movement.save
      redirect_to @product, notice: "Estoque movimentado com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def stock_movement_params
    params.require(:stock_movement).permit(:kind, :quantity, :description)
  end

  def authorize_stock_movement
    authorize! :create, StockMovement
  end
end
