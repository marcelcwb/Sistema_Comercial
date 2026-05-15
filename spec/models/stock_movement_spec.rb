require "rails_helper"

RSpec.describe StockMovement, type: :model do
  it "exige quantidade positiva para entrada" do
    movement = build(:stock_movement, kind: :entry, quantity: -1)

    expect(movement).not_to be_valid
    expect(movement.errors[:quantity]).to include("deve ser positiva para entradas")
  end

  it "exige quantidade negativa para saida" do
    movement = build(:stock_movement, kind: :exit, quantity: 1)

    expect(movement).not_to be_valid
    expect(movement.errors[:quantity]).to include("deve ser negativa para saidas")
  end
end
