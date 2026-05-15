class User < ApplicationRecord
  ROLE_NAMES = {
    "administrator" => "Administrador",
    "sales" => "Vendas",
    "finance" => "Financeiro",
    "operational" => "Operacional"
  }.freeze

  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  enum :role, {
    administrator: "administrator",
    sales: "sales",
    finance: "finance",
    operational: "operational"
  }

  before_validation :sync_admin_flag

  normalizes :email, with: ->(email) { email.to_s.strip.downcase }

  validates :name, presence: true
  validates :role, presence: true

  def admin?
    administrator? || self[:admin]
  end

  def role_name
    ROLE_NAMES.fetch(role, role.to_s.humanize)
  end

  private

  def sync_admin_flag
    self.admin = administrator?
  end
end
