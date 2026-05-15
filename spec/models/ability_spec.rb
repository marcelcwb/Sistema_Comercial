require "rails_helper"

RSpec.describe Ability, type: :model do
  subject(:ability) { described_class.new(user) }

  context "administrador" do
    let(:user) { build(:user, :administrator) }

    it "pode gerenciar todos os recursos" do
      expect(ability.can?(:manage, User)).to be(true)
      expect(ability.can?(:manage, FinancialEntry)).to be(true)
      expect(ability.can?(:destroy, Customer)).to be(true)
    end
  end

  context "vendas" do
    let(:user) { build(:user, :sales) }

    it "gerencia clientes e pedidos, mas nao financeiro" do
      expect(ability.can?(:manage, Customer)).to be(true)
      expect(ability.can?(:manage, Order)).to be(true)
      expect(ability.can?(:manage, FinancialEntry)).to be(false)
      expect(ability.can?(:destroy, Customer)).to be(false)
    end
  end

  context "financeiro" do
    let(:user) { build(:user, :finance) }

    it "gerencia financeiro e consulta pedidos" do
      expect(ability.can?(:manage, FinancialEntry)).to be(true)
      expect(ability.can?(:read, Order)).to be(true)
      expect(ability.can?(:manage, Product)).to be(false)
    end
  end

  context "operacional" do
    let(:user) { build(:user, role: :operational) }

    it "gerencia produtos e estoque" do
      expect(ability.can?(:manage, Product)).to be(true)
      expect(ability.can?(:manage, StockMovement)).to be(true)
      expect(ability.can?(:manage, User)).to be(false)
    end
  end
end
