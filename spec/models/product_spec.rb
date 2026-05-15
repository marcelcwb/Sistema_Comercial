require "rails_helper"

RSpec.describe Product, type: :model do
  describe "#stock_balance" do
    it "soma entradas e saidas de estoque" do
      product = create(:product, minimum_stock: 5)
      create(:stock_movement, product: product, kind: :entry, quantity: 12)
      create(:stock_movement, product: product, kind: :exit, quantity: -4)

      expect(product.stock_balance).to eq(8)
    end
  end

  describe "#low_stock?" do
    it "indica quando o saldo esta no minimo ou abaixo dele" do
      product = create(:product, minimum_stock: 10)
      create(:stock_movement, product: product, kind: :entry, quantity: 10)

      expect(product).to be_low_stock
    end
  end
end
