require "rails_helper"

RSpec.describe "Pedidos", type: :request do
  let(:customer) { create(:customer) }
  let(:product) { create(:product, price: 30) }

  before do
    sign_in create(:user, :sales)
    create(:stock_movement, product: product, kind: :entry, quantity: 10)
  end

  it "cria um pedido confirmado e movimenta estoque" do
    expect do
      post orders_path, params: {
        order: {
          customer_id: customer.id,
          ordered_on: Date.current,
          status: "confirmed",
          order_items_attributes: {
            "0" => {
              product_id: product.id,
              quantity: 2,
              unit_price: 30
            }
          }
        }
      }
    end.to change(Order, :count).by(1)
      .and change(FinancialEntry, :count).by(1)

    expect(response).to redirect_to(Order.last)
    expect(product.stock_balance).to eq(8)
    expect(Order.last.total).to eq(60)
  end
end
