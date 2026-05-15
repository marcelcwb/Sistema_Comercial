require "rails_helper"

RSpec.describe OrderItem, type: :model do
  it "calcula subtotal a partir da quantidade e valor unitario" do
    item = build(:order_item, quantity: 3, unit_price: 12.5)

    expect(item.calculate_subtotal).to eq(37.5)
    expect(item.subtotal).to eq(37.5)
  end
end
