class OrdersController < ApplicationController
  load_and_authorize_resource

  before_action :set_order, only: %i[show edit update destroy]
  before_action :load_form_collections, only: %i[new edit create update]

  def index
    @orders = Order.includes(:customer).order(created_at: :desc)
  end

  def show; end

  def new
    @order = Order.new(ordered_on: Date.current)
    3.times { @order.order_items.build }
  end

  def edit
    (3 - @order.order_items.size).times { @order.order_items.build }
  end

  def create
    @order = Order.new(order_params)

    if @order.save
      redirect_to @order, notice: "Pedido criado com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @order.update(order_params)
      redirect_to @order, notice: "Pedido atualizado com sucesso."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @order.destroy
    redirect_to orders_url, notice: "Pedido removido com sucesso."
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def load_form_collections
    @customers = Customer.order(:name)
    @products = Product.order(:name)
  end

  def order_params
    params.require(:order).permit(
      :customer_id,
      :status,
      :ordered_on,
      order_items_attributes: %i[id product_id quantity unit_price _destroy]
    )
  end
end
