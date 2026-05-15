class DashboardController < ApplicationController
  def index
    authorize! :read, :dashboard

    @customers_count = Customer.count
    @products_count = Product.count
    @open_receivables = can?(:read, FinancialEntry) ? FinancialEntry.receivable.open.sum(:amount) : nil
    @open_payables = can?(:read, FinancialEntry) ? FinancialEntry.payable.open.sum(:amount) : nil
    @low_stock_products = Product.all.select(&:low_stock?)
    @recent_orders = Order.includes(:customer).order(created_at: :desc).limit(5)
  end
end
