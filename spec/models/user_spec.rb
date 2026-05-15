require "rails_helper"

RSpec.describe User, type: :model do
  it "sincroniza o campo legado admin quando o perfil e administrador" do
    user = build(:user, role: :administrator)

    user.valid?

    expect(user.admin).to be(true)
  end

  it "normaliza email removendo espacos e caixa alta" do
    user = create(:user, email: " TESTE@SISTEMA.TEST ")

    expect(user.email).to eq("teste@sistema.test")
  end
end
