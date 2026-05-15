require "rails_helper"

RSpec.describe "Clientes", type: :request do
  before do
    sign_in create(:user, :sales)
  end

  it "cria um cliente pelo perfil de vendas" do
    expect do
      post customers_path, params: {
        customer: {
          name: "Cliente BDD",
          document: "99887766000155",
          email: "cliente-bdd@sistema.test",
          phone: "(11) 99999-0000",
          city: "Sao Paulo",
          state: "SP"
        }
      }
    end.to change(Customer, :count).by(1)

    expect(response).to redirect_to(Customer.last)
    expect(Customer.last.name).to eq("Cliente BDD")
  end
end
