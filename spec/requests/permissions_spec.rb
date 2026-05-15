require "rails_helper"

RSpec.describe "Permissionamento por perfil", type: :request do
  describe "perfil vendas" do
    let(:user) { create(:user, :sales) }

    before { sign_in user }

    it "acessa pedidos" do
      get orders_path

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Pedidos")
    end

    it "nao acessa gerenciamento financeiro" do
      get financial_entries_path

      expect(response).to redirect_to(root_path)
      follow_redirect!
      expect(response.body).to include("Voce nao tem permissao")
    end
  end

  describe "perfil financeiro" do
    let(:user) { create(:user, :finance) }

    before { sign_in user }

    it "acessa financeiro" do
      get financial_entries_path

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Contas")
    end

    it "nao cria produtos" do
      get new_product_path

      expect(response).to redirect_to(root_path)
    end
  end

  describe "perfil operacional" do
    let(:user) { create(:user, role: :operational) }

    before { sign_in user }

    it "acessa produtos" do
      get products_path

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Produtos")
    end

    it "nao acessa usuarios" do
      get users_path

      expect(response).to redirect_to(root_path)
    end
  end

  describe "administrador" do
    it "acessa gerenciamento de usuarios" do
      sign_in create(:user, :administrator)

      get users_path

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Usuarios")
    end
  end
end
