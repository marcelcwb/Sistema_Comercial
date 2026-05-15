require "rails_helper"

RSpec.describe "Autenticacao", type: :request do
  it "redireciona visitantes para a tela de login" do
    get root_path

    expect(response).to redirect_to(new_user_session_path)
  end

  it "permite que usuario autenticado acesse o dashboard" do
    sign_in create(:user, :sales)

    get root_path

    expect(response).to have_http_status(:ok)
    expect(response.body).to include("Dashboard comercial")
  end
end
