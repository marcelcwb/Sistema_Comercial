require "rails_helper"

RSpec.describe Order, type: :model do
  it "permite rascunho sem itens" do
    order = build(:order, status: :draft)

    expect(order).to be_valid
  end

  it "nao confirma pedido sem itens" do
    order = build(:order, status: :confirmed)

    expect(order).not_to be_valid
    expect(order.errors[:base]).to include("adicione ao menos um item ao pedido")
  end

  it "calcula o total dos itens antes de salvar" do
    order = build(:order)
    order.order_items << build(:order_item, order: order, quantity: 2, unit_price: 10)
    order.order_items << build(:order_item, order: order, quantity: 1, unit_price: 7.5)

    order.save!

    expect(order.total).to eq(27.5)
  end

  it "gera saida de estoque e conta a receber quando confirmado" do
    product = create(:product, price: 20)
    create(:stock_movement, product: product, kind: :entry, quantity: 10)
    order = create(:order)
    order.order_items.create!(product: product, quantity: 2, unit_price: 20)

    order.update!(status: :confirmed)

    expect(product.stock_balance).to eq(8)
    expect(order.financial_entry).to have_attributes(
      kind: "receivable",
      status: "open",
      amount: 40
    )
  end
end
