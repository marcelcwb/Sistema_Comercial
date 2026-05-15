User.find_or_create_by!(email: "admin@sistema.test") do |user|
  user.name = "Administrador"
  user.password = "admin123"
  user.password_confirmation = "admin123"
  user.admin = true
  user.role = :administrator
end

User.find_or_create_by!(email: "vendas@sistema.test") do |user|
  user.name = "Equipe de Vendas"
  user.password = "vendas123"
  user.password_confirmation = "vendas123"
  user.role = :sales
end

User.find_or_create_by!(email: "financeiro@sistema.test") do |user|
  user.name = "Equipe Financeira"
  user.password = "financeiro123"
  user.password_confirmation = "financeiro123"
  user.role = :finance
end

customer = Customer.find_or_create_by!(document: "12345678000199") do |c|
  c.name = "Mercado Central"
  c.email = "compras@mercadocentral.test"
  c.phone = "(11) 4000-1000"
  c.city = "Sao Paulo"
  c.state = "SP"
end

coffee = Product.find_or_create_by!(sku: "CAF-001") do |p|
  p.name = "Cafe Especial 500g"
  p.price = 32.9
  p.minimum_stock = 10
end

tea = Product.find_or_create_by!(sku: "CHA-001") do |p|
  p.name = "Cha Verde 100g"
  p.price = 18.5
  p.minimum_stock = 8
end

StockMovement.find_or_create_by!(product: coffee, kind: :entry, quantity: 40, description: "Estoque inicial")
StockMovement.find_or_create_by!(product: tea, kind: :entry, quantity: 25, description: "Estoque inicial")

order = Order.find_or_create_by!(customer: customer, ordered_on: Date.current) do |o|
  o.status = :draft
end

if order.order_items.empty?
  order.order_items.create!(product: coffee, quantity: 3, unit_price: coffee.price)
  order.order_items.create!(product: tea, quantity: 2, unit_price: tea.price)
  order.recalculate_total!
end

order.update!(status: :confirmed) unless order.confirmed?

FinancialEntry.find_or_create_by!(order: order, description: "Recebimento pedido ##{order.id}") do |entry|
  entry.kind = :receivable
  entry.status = :open
  entry.amount = order.total
  entry.due_on = 7.days.from_now.to_date
end
